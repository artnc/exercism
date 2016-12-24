defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ [:alice, :bob, :charlie, :david, :eve, :fred, :ginny, :harriet, :ileana, :joseph, :kincaid, :larry]) do
    student_names = Enum.sort(student_names)
    name_map = %{
      "C" => :clover,
      "G" => :grass,
      "R" => :radishes,
      "V" => :violets,
    }
    student_map =
      student_names
      |> Enum.reduce(%{}, &(Map.put(&2, &1, {})))
    [top, bottom] =
      String.split(info_string)
      |> Enum.map(&String.graphemes/1)
    Stream.zip(top, bottom)
    |> Stream.chunk(2)
    |> Stream.zip(student_names)
    |> Enum.reduce(student_map, fn(x, acc) ->
      {[{a, c}, {b, d}], name} = x
      plant_names =
        [a, b, c, d]
        |> Enum.map(&(name_map[&1]))
        |> List.to_tuple
      Map.put(acc, name, plant_names)
    end)
  end
end
