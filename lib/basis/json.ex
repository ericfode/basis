defmodule Basis.Json do
  @moduledoc """
  Small wrapper around OTP's JSON encoder.

  Basis keeps this dependency-free. The wrapper normalizes Elixir terms whose
  native representation does not map directly to JSON, especially `nil`.
  """

  def encode!(term) do
    term
    |> normalize()
    |> :json.encode()
    |> IO.iodata_to_binary()
  end

  def decode!(body) when is_binary(body), do: :json.decode(body)

  def normalize(nil), do: :null
  def normalize(true), do: true
  def normalize(false), do: false
  def normalize(atom) when is_atom(atom), do: Atom.to_string(atom)
  def normalize(binary) when is_binary(binary), do: binary
  def normalize(number) when is_number(number), do: number

  def normalize(list) when is_list(list), do: Enum.map(list, &normalize/1)

  def normalize(%_{} = struct) do
    struct
    |> Map.from_struct()
    |> normalize()
  end

  def normalize(map) when is_map(map) do
    Map.new(map, fn {key, value} -> {normalize_key(key), normalize(value)} end)
  end

  defp normalize_key(key) when is_atom(key), do: Atom.to_string(key)
  defp normalize_key(key) when is_binary(key), do: key
  defp normalize_key(key), do: to_string(key)
end
