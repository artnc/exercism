defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, schedule) do
    # Not using day_of_week/1 because Elixir 1.4 isn't out yet :(
    offsets = {0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334}
    days = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
    weekdays = %{
      sunday: 0,
      monday: 1,
      tuesday: 2,
      wednesday: 3,
      thursday: 4,
      friday: 5,
      saturday: 6,
    }
    month = month - 1
    day =
      1..elem(days, month)
      |> Enum.find(fn(d) ->
        cond do
          rem(elem(offsets, month) + d + 1, 7) != weekdays[weekday] ->
            false
          schedule == :first ->
            true
          schedule == :second ->
            d > 7
          schedule == :third ->
            d > 14
          schedule == :fourth ->
            d > 21
          schedule == :teenth ->
            13 <= d and d <= 19
          schedule == :last ->
            d > elem(days, month) - 7
          true ->
            false
        end
      end)
    {year, month + 1, day}
  end
end
