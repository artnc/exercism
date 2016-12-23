defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    words = Regex.scan(~r/[[:alpha:]0-9-]+/u, sentence)
    Enum.reduce(words, %{}, fn(x, acc) ->
      Map.update(acc, x |> hd |> String.downcase, 1, &(&1 + 1))
    end)
  end
end
