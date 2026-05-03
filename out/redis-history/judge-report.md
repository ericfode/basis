# Historical Spec Mining Judge Report

Repo: `/private/tmp/testing-rl-external/redis`
Root: `ed9b544e10b84cd43348ddfab7068b610a5df1f7`
Target: `2432f55278b8fd01a4f7c4b9f5a9e2dcc5ddd4f8`
Samples: 14

## Objective

Maximize the amount of project history for which a spec written at the beginning remains valid, while still covering the high-weight essence of the system.

## Best Prompt Policy

- Prompt ID: `genesis-stable-essence-stricter-1:e2`
- Reward: `0.8547`
- Time validity: `1`
- Average coverage: `0.6729`
- Stability: `1`
- Genesis coverage: `0.7692`

## Writer Prompt

Write a compact as-built spec from the first snapshot. Include only high-essence claims that are evidenced at the root and remain stable through later snapshots. Tighten to claims with stronger temporal support.

## Judge Prompt

Reward temporal validity first, then essence coverage. Penalize claims absent from the first snapshot.

## Episode Scores

- Episode 1: best `genesis-stable-essence:e1` reward `0.8396`, valid 13/14, coverage `0.7359`.
- Episode 2: best `genesis-stable-essence-stricter-1:e2` reward `0.8547`, valid 14/14, coverage `0.6729`.
- Episode 3: best `genesis-stable-essence-stricter-1-keep:e3` reward `0.8547`, valid 14/14, coverage `0.6729`.
- Episode 4: best `genesis-stable-essence-stricter-1-keep:e4` reward `0.8547`, valid 14/14, coverage `0.6729`.
- Episode 5: best `genesis-stable-essence-stricter-1-keep:e5` reward `0.8547`, valid 14/14, coverage `0.6729`.

## Sample Validity

- 2009-03-22 10:30:00 +0100 `ed9b544e10b8`: valid, coverage `0.837`.
- 2010-05-26 17:55:28 +0200 `90fdc8269782`: valid, coverage `0.739`.
- 2011-11-09 21:59:27 +0100 `dab5332f95bd`: valid, coverage `0.732`.
- 2013-03-14 21:27:12 +0100 `90e99a208277`: valid, coverage `0.707`.
- 2014-03-27 15:01:24 +0100 `8f52173b2cdf`: valid, coverage `0.707`.
- 2015-05-25 12:06:25 +0200 `4082c38a60ee`: valid, coverage `0.707`.
- 2017-01-10 11:33:50 +0100 `e91f0ea1b3b1`: valid, coverage `0.683`.
- 2018-09-25 12:31:46 +0200 `448d696549dc`: valid, coverage `0.661`.
- 2019-11-19 11:23:43 +0100 `b42466b92586`: valid, coverage `0.626`.
- 2020-11-24 17:58:10 +0200 `7e5a6313f0ad`: valid, coverage `0.626`.
- 2021-10-04 12:10:31 +0300 `fba15850e5c3`: valid, coverage `0.626`.
- 2022-08-24 12:51:36 +0300 `c1bd61a4a502`: valid, coverage `0.59`.
- 2024-06-04 20:35:26 +0800 `9a2c6ba4e7be`: valid, coverage `0.59`.
- 2026-04-30 21:38:25 +0800 `2432f55278b8`: valid, coverage `0.59`.

