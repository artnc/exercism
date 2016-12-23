defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    base_histogram = get_histogram(base)
    candidates
    |> Enum.filter(&(String.downcase(&1) != String.downcase(base)))
    |> Enum.filter(&(get_histogram(&1) == base_histogram))
  end

  defp get_histogram(string) do
    string
    |> String.graphemes
    |> Enum.reduce(%{}, fn(x, acc) ->
      Map.update(acc, String.downcase(x), 1, &(&1 + 1))
    end)
  end
end
