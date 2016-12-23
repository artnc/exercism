defmodule Sublist do
  @doc """
  Returns whether the first list is a superlist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      a === b ->
        :equal
      length(a) > length(b) and superlist?(a, b) ->
        :superlist
      length(a) < length(b) and superlist?(b, a) ->
        :sublist
      true ->
        :unequal
    end
  end

  defp superlist?(a, b) do
    cond do
      length(a) < length(b) ->
        false
      Enum.take(a, length(b)) === b ->
        true
      true ->
        a |> tl |> superlist?(b)
    end
  end
end
