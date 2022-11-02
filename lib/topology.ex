defmodule Topology do
  # import Set

  @moduledoc """
  Returns a topology of the given set.
  """

  @doc """
  Returns a topology of the given set.

  ## Examples

      iex> Topology.topologies(MapSet.new([:a, :b]))
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
  def topologies(set) do
    set
    |> Set.power_set()
    |> Set.power_set()
    |> Enum.filter(&first(&1, set))
    |> Enum.filter(&second(&1))
    |> Enum.filter(&third(&1))
    |> MapSet.new()
  end

  defdelegate open_set_systems(set), to: __MODULE__, as: :topologies

  def closed_set_system({underlying_set, topology}) do
    topology
    |> Enum.map(&MapSet.difference(underlying_set, &1))
    |> MapSet.new()
  end

  @doc """
  Returns a discreate topology of the given set.

  ## Examples

      iex> Topology.discrete_topology(MapSet.new([:a, :b]))
      MapSet.new([MapSet.new([]), MapSet.new([:a]), MapSet.new([:b]), MapSet.new([:a, :b])])

  """
  def discrete_topology(set), do: set |> Set.power_set()

  @doc """
  Returns a indiscreate topology of the given set.

  ## Examples

      iex> Topology.indiscrete_topology(MapSet.new([:a, :b]))
      MapSet.new([MapSet.new(), MapSet.new([:a, :b])])

  """
  def indiscrete_topology(set), do: MapSet.new([MapSet.new([]), set])

  @doc """
  Returns a topological spaces of the given set.

  ## Examples

      iex> Topology.topological_spaces(MapSet.new([:a, :b]))
      [
        {MapSet.new([:a, :b]), MapSet.new([MapSet.new([]), MapSet.new([:a, :b])])},
        {MapSet.new([:a, :b]), MapSet.new([MapSet.new([]), MapSet.new([:a]), MapSet.new([:a, :b])])},
        {MapSet.new([:a, :b]), MapSet.new([MapSet.new([]), MapSet.new([:b]), MapSet.new([:a, :b])])},
        {MapSet.new([:a, :b]), MapSet.new([MapSet.new([]), MapSet.new([:a]), MapSet.new([:b]), MapSet.new([:a, :b])])}
      ]

  """
  def topological_spaces(set) do
    topologies(set)
    |> Enum.map(&{set, &1})
  end

  @doc """
  Returns a discrete space of the given set.

  ## Examples

      iex> Topology.discrete_space(MapSet.new([:a, :b]))
      {MapSet.new([:a, :b]), MapSet.new([MapSet.new([]), MapSet.new([:a]), MapSet.new([:b]), MapSet.new([:a, :b])])}

  """
  def discrete_space(set), do: {set, discrete_topology(set)}

  @doc """
  Returns a discrete space of the given set.

  ## Examples

      iex> Topology.indiscrete_space(MapSet.new([:a, :b]))
      {MapSet.new([:a, :b]), MapSet.new([MapSet.new([]), MapSet.new([:a, :b])])}

  """
  def indiscrete_space(set), do: {set, indiscrete_topology(set)}

  def is_open_set?(set, {_underlying_set, topology}), do: MapSet.member?(topology, set)

  def is_closed_set?(set, {underlying_set, topology}) do
    set
    |> then(&MapSet.difference(underlying_set, &1))
    |> then(&MapSet.member?(topology, &1))
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
