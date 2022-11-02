defmodule Topology.Interior do
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
  def interior_operator(m, topological_space) do
    {underlying_set, topology} = topological_space

    cond do
      m |> MapSet.subset?(underlying_set) ->
        topology
        |> Enum.filter(&MapSet.subset?(&1, m))
        |> Set.union()

      true ->
        {:error, "The set is not a interior of the topological space"}
    end
  end
end
