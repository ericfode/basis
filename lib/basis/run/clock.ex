defmodule Basis.Run.Clock do
  @moduledoc false

  def now do
    DateTime.utc_now()
    |> DateTime.truncate(:second)
    |> DateTime.to_iso8601()
  end
end
