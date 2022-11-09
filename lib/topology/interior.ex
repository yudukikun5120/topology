defmodule Topology.Interior do
  @spec interior_operator(MapSet.t(), {Topology.underlying_set(), Topology.topology()}) ::
          MapSet.t() | {:error, <<_::368>>}
  @doc """
  Returns a interior of the given set for topological space.


  ## Examples

      iex> topological_space =
      ...>  {
      ...>    MapSet.new([:a, :b, :c]),
      ...>    MapSet.new([
      ...>      MapSet.new([]),
      ...>      MapSet.new([:b]),
      ...>      MapSet.new([:a, :b]),
      ...>      MapSet.new([:a, :b, :c])
      ...>    ])
      ...>  }
      iex> m = MapSet.new([:a, :b])
      iex> Topology.Interior.interior_operator(m, topological_space)
      MapSet.new([:a, :b])

  """
  def interior_operator(m, {underlying_set, topology}) do
    cond do
      m |> MapSet.subset?(underlying_set) ->
        topology
        |> Enum.filter(&MapSet.subset?(&1, m))
        |> Set.union()

      true ->
        {:error, "The set is not a subset of the underlying set."}
    end
  end

  def closure_operator(m, {underlying_set, topology}) do
    cond do
      m |> MapSet.subset?(underlying_set) ->
        Topology.closed_set_system({underlying_set, topology})
        |> Enum.filter(&MapSet.subset?(m, &1))
        |> Set.intersection()

      true ->
        {:error, "The set is not a subset of the underlying set."}
    end
  end
end
