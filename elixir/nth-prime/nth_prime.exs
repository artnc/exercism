defmodule Prime do

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) do
    if count < 1 do
      raise "Invalid count"
    end

    Stream.iterate(2, &(&1 + 1))
    |> Enum.reduce_while({0, []}, fn(x, acc) ->
      {found, primes} = acc
      if prime?(x, primes) do
        found = found + 1
        if found == count do
          {:halt, x}
        else
          {:cont, {found, [x | primes]}}
        end
      else
        {:cont, acc}
      end
    end)
  end

  defp prime?(n, primes), do: Enum.all?(primes, &(rem(n, &1) > 0))

end
