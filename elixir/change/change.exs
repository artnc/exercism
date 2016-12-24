defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns :error if it is not possible to compute the right amount of coins.
    Otherwise returns the tuple {:ok, map_of_coins}

    ## Examples

      iex> Change.generate(3, [5, 10, 15])
      :error

      iex> Change.generate(18, [1, 5, 10])
      {:ok, %{1 => 3, 5 => 1, 10 => 1}}

  """

  @spec generate(integer, list) :: {:ok, map} | :error
  def generate(amount, coins) do
    coins = if coins == [], do: [-1], else: coins
    initial_table =
      coins
      |> Stream.zip(Stream.cycle([0]))
      |> Enum.into(%{})

    {score, solution} =
      1..amount
      |> Enum.reduce(%{0 => {0, initial_table}}, fn(a, table) ->
        best_coin = Enum.min_by(coins, fn(c) ->
          table
          |> Map.get(a - c, {nil})
          |> elem(0)
        end)
        {score, change} = Map.get(table, a - best_coin, {nil, nil})
        if score do
          new_change = Map.update(change, best_coin, 1, &(&1 + 1))
          Map.put(table, a, {score + 1, new_change})
        else
          table
        end
      end)
      |> Map.get(amount, {nil, nil})
    if score, do: {:ok, solution}, else: :error
  end
end
