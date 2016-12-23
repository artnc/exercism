defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    brackets = ~w"( ) [ ] { }" |> Enum.into(MapSet.new)
    openers = %{")" => "(", "]" => "[", "}" => "{"}
    try do
      0 == str
      |> String.graphemes
      |> Stream.filter(&(MapSet.member?(brackets, &1)))
      |> Enum.reduce([], fn(x, acc) ->
        if Map.has_key?(openers, x) do
          if acc == [] do
            raise "Unmatched closing bracket"
          else
            [h | t] = acc
            if h == openers[x] do
              t
            else
              raise "Mismatched closing bracket"
            end
          end
        else
          [x | acc]
        end
      end)
      |> length
    rescue
      RuntimeError -> false
    end
  end
end
