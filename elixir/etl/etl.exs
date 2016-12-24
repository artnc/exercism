defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(input) do
    input
    |> Map.to_list
    |> Enum.reduce(%{}, fn(x, acc) ->
      {value, tokens} = x
      Enum.reduce(tokens, acc, &(Map.put(&2, String.downcase(&1), value)))
    end)
  end
end
