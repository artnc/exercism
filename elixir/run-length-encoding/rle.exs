defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    Regex.scan(~r/(.)\1*/u, string)
    |> Enum.map(fn(x) ->
      run = hd(x)
      (run |> String.length |> to_string) <> String.first(run)
    end)
    |> Enum.join
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    Regex.scan(~r/(\d+)(\w)/u, string)
    |> Enum.map(fn(x) ->
      [_, num, char] = x
      1..(num |> Integer.parse |> elem(0))
      |> Enum.map(fn(_) -> char end)
      |> Enum.join
    end)
    |> Enum.join
  end
end
