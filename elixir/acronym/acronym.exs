defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    Enum.map(Regex.scan(~r/\w[a-z]*/u, string), fn(x) ->
      x |> hd |> String.slice(0..0) |> String.upcase
    end)
    |> Enum.join
  end
end
