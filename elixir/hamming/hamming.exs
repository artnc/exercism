defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(strand1, strand2) do
    if length(strand1) == length(strand2) do
      distance =
        Stream.zip((strand1), (strand2))
        |> Stream.filter(&(elem(&1, 0) != elem(&1, 1)))
        |> Enum.count
      {:ok, distance}
    else
      {:error, "Lists must be the same length"}
    end
  end
end
