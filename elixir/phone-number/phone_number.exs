defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("123-456-7890")
  "1234567890"

  iex> Phone.number("+1 (303) 555-1212")
  "3035551212"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t) :: String.t
  def number(raw) do
    possible_digits = ~w(0 1 2 3 4 5 6 7 8 9) |> Enum.into(MapSet.new)
    if Regex.run(~r/[a-z]/, raw) do
      "0000000000"
    else
      digits =
        raw
        |> String.graphemes
        |> Stream.filter(&(MapSet.member?(possible_digits, &1)))
        |> Enum.join
      cond do
        String.length(digits) == 10 ->
          digits
        String.length(digits) == 11 and String.first(digits) == "1" ->
          String.slice(digits, 1..10)
        true ->
          "0000000000"
      end
    end
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("123-456-7890")
  "123"

  iex> Phone.area_code("+1 (303) 555-1212")
  "303"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    raw
    |> number
    |> String.slice(-10..-8)
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("123-456-7890")
  "(123) 456-7890"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    last_ten =
      raw
      |> number
      |> String.slice(-10..-1)
    "(#{String.slice(last_ten, 0..2)}) #{String.slice(last_ten, 3..5)}-#{String.slice(last_ten, 6..9)}"
  end
end
