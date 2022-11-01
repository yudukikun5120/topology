defmodule Topology do
  # import Set

  @moduledoc """
  Returns a topology of the given set.
  """

  @doc """
  Returns a topology of the given set.

  ## Examples

      iex> Topology.topology(MapSet.new([:a, :b]))
      MapSet.new([
        MapSet.new([MapSet.new([]), MapSet.new([:a, :b])]),
        MapSet.new([MapSet.new([]), MapSet.new([:a]), MapSet.new([:a, :b])]),
        MapSet.new([MapSet.new([]), MapSet.new([:b]), MapSet.new([:a, :b])]),
        MapSet.new([
          MapSet.new([]),
          MapSet.new([:a]),
          MapSet.new([:b]),
          MapSet.new([:a, :b])
        ])
      ])

  """
  def topology(set) do
    set
    |> Set.power_set()
    |> Set.power_set()
    |> Enum.filter(&first(&1, set))
    |> Enum.filter(&second(&1))
    |> Enum.filter(&third(&1))
    |> MapSet.new()
  end

  defp first(family_of_subsets, underlying_set) do
    MapSet.member?(family_of_subsets, underlying_set) &&
      MapSet.member?(family_of_subsets, MapSet.new())
  end

  defp second(family_of_subsets) do
    family_of_subsets
    |> Set.power_set()
    |> MapSet.delete(MapSet.new([]))
    |> Enum.map(&Set.intersection(&1))
    |> Enum.all?(&MapSet.member?(family_of_subsets, &1))
  end

  defp third(family_of_subsets) do
    family_of_subsets
    |> Set.power_set()
    |> MapSet.delete(MapSet.new([]))
    |> Enum.map(&Set.union(&1))
    |> Enum.all?(&MapSet.member?(family_of_subsets, &1))
  end
end
