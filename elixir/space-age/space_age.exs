defmodule SpaceAge do
  @type planet :: :mercury | :venus | :earth | :mars | :jupiter
                | :saturn | :uranus | :neptune

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
    earth_year_seconds = 31557600
    orbits_in_earth_years = %{
      :earth => 1,
      :jupiter => 11.862615,
      :mars => 1.8808158,
      :mercury => 0.2408467,
      :neptune => 164.79132,
      :saturn => 29.447498,
      :uranus => 84.016846,
      :venus => 0.61519726,
    }
    seconds / (orbits_in_earth_years[planet] * earth_year_seconds)
  end
end
