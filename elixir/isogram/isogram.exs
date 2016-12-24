defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t) :: boolean
  def isogram?(sentence) do
    stripped =
      sentence
      |> String.graphemes
      |> Enum.filter(&(&1 != "-" && &1 != " "))
    length(stripped) == stripped
    |> Enum.into(MapSet.new)
    |> MapSet.size
  end

end
