#!/usr/bin/env python3
import argparse
import os
import socket
import subprocess
import sys
import tempfile
import time
from pathlib import Path

import redis


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("server", nargs="+", help="candidate server.mjs paths")
    args = parser.parse_args()

    results = []
    for server in args.server:
        results.append(evaluate(Path(server)))

    print_json({"results": results, "summary": summarize(results)})


def evaluate(server_path):
    result = {
        "server": str(server_path),
        "passed": 0,
        "total": 0,
        "buckets": {},
        "failures": [],
    }
    if not server_path.exists():
        result["failures"].append("server file missing")
        return finish(result)

    port = free_port()
    env = os.environ.copy()
    env["REDIS_PORT"] = str(port)
    proc = subprocess.Popen(
        ["node", str(server_path)],
        cwd=str(server_path.parent),
        env=env,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
    )
    try:
        wait_for_port(port, proc)
        client = redis.Redis(host="127.0.0.1", port=port, socket_timeout=1.0, decode_responses=False)
        run_suite(client, result)
    except Exception as exc:
        result["failures"].append(f"harness failure: {type(exc).__name__}: {exc}")
    finally:
        proc.terminate()
        try:
            proc.wait(timeout=1)
        except subprocess.TimeoutExpired:
            proc.kill()
        stderr = proc.stderr.read() if proc.stderr else ""
        if stderr.strip():
            result["stderr_tail"] = stderr.strip()[-1000:]

    return finish(result)


def run_suite(r, result):
    check(result, "connection", "ping", lambda: r.ping() is True)
    check(result, "connection", "echo", lambda: r.echo(b"hello") == b"hello")

    r.flushdb()
    check(result, "strings", "set get bytes", lambda: r.set(b"k", b"v") is True and r.get(b"k") == b"v")
    check(result, "strings", "missing get is none", lambda: r.get(b"missing") is None)
    check(result, "strings", "exists del", lambda: r.exists(b"k", b"missing") == 1 and r.delete(b"k", b"missing") == 1 and r.exists(b"k") == 0)
    check(result, "strings", "mset mget", lambda: r.mset({b"a": b"1", b"b": b"2"}) is True and r.mget(b"a", b"b", b"c") == [b"1", b"2", None])
    check(result, "strings", "conditional set", lambda: conditional_set_case(r))
    check(result, "strings", "binary value", lambda: r.set(b"bin", b"a\x00b\r\nc") is True and r.get(b"bin") == b"a\x00b\r\nc")

    r.flushdb()
    check(result, "integers", "incr creates", lambda: r.incr(b"n") == 1 and r.incrby(b"n", 41) == 42 and r.execute_command("DECR", b"n") == 41 and r.execute_command("DECRBY", b"n", 1) == 40 and r.get(b"n") == b"40")
    check_raises(result, "integers", "incr invalid integer", redis.ResponseError, lambda: invalid_integer_case(r))

    r.flushdb()
    check(result, "expiry", "expire ttl persist", lambda: expiry_case(r))
    check(result, "expiry", "key expires", lambda: expires_case(r))

    r.flushdb()
    check(result, "lists", "push range pop", lambda: list_case(r))
    check_raises(result, "lists", "wrong type list op", redis.ResponseError, lambda: wrong_type_list_case(r))
    check_raises(result, "lists", "wrong type string op", redis.ResponseError, lambda: wrong_type_string_case(r))

    r.flushdb()
    check(result, "pipeline", "pipeline order", lambda: pipeline_case(r))
    check(result, "transaction", "multi exec", lambda: transaction_case(r))
    check(result, "meta", "type dbsize flushdb", lambda: meta_case(r))


def conditional_set_case(r):
    return (
        r.set(b"c", b"1", nx=True) is True
        and r.set(b"c", b"2", nx=True) is None
        and r.get(b"c") == b"1"
        and r.set(b"c", b"3", xx=True) is True
        and r.get(b"c") == b"3"
        and r.set(b"absent", b"x", xx=True) is None
    )


def invalid_integer_case(r):
    r.set(b"bad", b"not-int")
    r.incr(b"bad")


def expiry_case(r):
    r.set(b"e", b"v")
    if r.ttl(b"e") != -1:
        return False
    if not r.expire(b"e", 5):
        return False
    ttl = r.ttl(b"e")
    if ttl < 0 or ttl > 5:
        return False
    return r.persist(b"e") is True and r.ttl(b"e") == -1


def expires_case(r):
    r.set(b"soon", b"gone", px=50)
    time.sleep(0.08)
    return r.get(b"soon") is None and r.ttl(b"soon") == -2


def list_case(r):
    return (
        r.lpush(b"lst", b"b", b"a") == 2
        and r.rpush(b"lst", b"c") == 3
        and r.lrange(b"lst", 0, -1) == [b"a", b"b", b"c"]
        and r.lrange(b"lst", -2, -1) == [b"b", b"c"]
        and r.lpop(b"lst") == b"a"
        and r.rpop(b"lst") == b"c"
        and r.llen(b"lst") == 1
    )


def wrong_type_list_case(r):
    r.set(b"s", b"v")
    r.lpush(b"s", b"x")


def wrong_type_string_case(r):
    r.rpush(b"l", b"x")
    r.get(b"l")


def pipeline_case(r):
    p = r.pipeline(transaction=False)
    p.set(b"p", b"1")
    p.incr(b"p")
    p.get(b"p")
    return p.execute() == [True, 2, b"2"]


def transaction_case(r):
    p = r.pipeline(transaction=True)
    p.set(b"t", b"1")
    p.incr(b"t")
    p.get(b"t")
    return p.execute() == [True, 2, b"2"]


def meta_case(r):
    r.flushdb()
    r.set(b"a", b"1")
    r.rpush(b"l", b"x")
    return r.type(b"a") == b"string" and r.type(b"l") == b"list" and r.dbsize() == 2 and r.flushdb() is True and r.dbsize() == 0


def check(result, bucket, name, fn):
    result["total"] += 1
    result["buckets"].setdefault(bucket, {"passed": 0, "total": 0})
    result["buckets"][bucket]["total"] += 1
    try:
        ok = bool(fn())
    except Exception as exc:
        ok = False
        result["failures"].append(f"{bucket}/{name}: {type(exc).__name__}: {exc}")
    if ok:
        result["passed"] += 1
        result["buckets"][bucket]["passed"] += 1
    elif not any(f"{bucket}/{name}:" in failure for failure in result["failures"]):
        result["failures"].append(f"{bucket}/{name}: returned false")


def check_raises(result, bucket, name, exc_type, fn):
    def wrapped():
        try:
            fn()
        except exc_type:
            return True
        return False

    check(result, bucket, name, wrapped)


def finish(result):
    result["score"] = result["passed"] / result["total"] if result["total"] else 0
    for bucket in result["buckets"].values():
        bucket["score"] = bucket["passed"] / bucket["total"] if bucket["total"] else 0
    return result


def summarize(results):
    scores = [result["score"] for result in results]
    return {
        "n": len(results),
        "mean": sum(scores) / len(scores) if scores else 0,
        "min": min(scores) if scores else 0,
        "max": max(scores) if scores else 0,
    }


def free_port():
    sock = socket.socket()
    sock.bind(("127.0.0.1", 0))
    port = sock.getsockname()[1]
    sock.close()
    return port


def wait_for_port(port, proc, timeout=2.0):
    deadline = time.time() + timeout
    while time.time() < deadline:
        if proc.poll() is not None:
            stderr = proc.stderr.read() if proc.stderr else ""
            raise RuntimeError(f"server exited early: {stderr}")
        try:
            with socket.create_connection(("127.0.0.1", port), timeout=0.05):
                return
        except OSError:
            time.sleep(0.02)
    raise TimeoutError(f"server did not listen on {port}")


def print_json(value):
    import json

    print(json.dumps(value, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
