defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    table = %{"A" => "U", "C" => "G", "G" => "C", "T" => "A"}
    dna
    |> to_string
    |> String.graphemes
    |> Enum.map(&(table[&1]))
    |> Enum.join
    |> to_charlist
  end
end
