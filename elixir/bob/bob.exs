defmodule Bob do
  def hey(input) do
    cond do
      String.ends_with?(input, "?") ->
        "Sure."
      String.upcase(input) == input and String.downcase(input) != input ->
        "Whoa, chill out!"
      String.trim(input) == "" ->
        "Fine. Be that way!"
      true ->
        "Whatever."
    end
  end
end
