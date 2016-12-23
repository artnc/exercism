if !System.get_env("EXERCISM_TEST_EXAMPLES") do
  Code.load_file("pangram.exs", __DIR__)
end

ExUnit.start
ExUnit.configure exclude: :pending, trace: true

defmodule PangramTest do
  use ExUnit.Case

  # @tag :pending
  test "empty sentence" do
    refute Pangram.pangram?("")
  end

  test "pangram with only lower case" do
    refute Pangram.pangram?("the quick brown fox jumps over the lazy dog")
  end

  test "missing character 'x'" do
    refute Pangram.pangram?("a quick movement of the enemy will jeopardize five gunboats")
  end

  test "another missing character 'x'" do
    refute Pangram.pangram?("the quick brown fish jumps over the lazy dog")
  end

  test "pangram with underscores" do
    refute Pangram.pangram?("the_quick_brown_fox_jumps_over_the_lazy_dog")
  end

  test "pangram with numbers" do
    refute Pangram.pangram?("the 1 quick brown fox jumps over the 2 lazy dogs")
  end

  test "missing letters replaced by numbers" do
    refute Pangram.pangram?("7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog")
  end

  test "pangram with mixed case and punctuation" do
    refute Pangram.pangram?("Five quacking Zephyrs jolt my wax bed.")
  end

  test "pangram with non ascii characters" do
    refute Pangram.pangram?("Victor jagt zwölf Boxkämpfer quer über den großen Sylter Deich.")
  end

  test "pangram in alphabet other than ASCII" do
    refute Pangram.pangram?("Широкая электрификация южных губерний даст мощный толчок подъёму сельского хозяйства.")
  end
end
