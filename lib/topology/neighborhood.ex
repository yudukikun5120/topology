defmodule Neighborhood do
  @spec is_neighborhood?(Topology.topological_space(), atom(), MapSet.t()) ::
          {:error, :subset_is_not_in_underlying_set | :x_is_not_in_underlying_set}
          | {:ok, boolean()}
  @doc """
  Returns a boolean value indicating whether the given set is a neighborhood of the given x in topological space.

  ## Examples

      iex> topological_space =
      ...>  {
      ...>   MapSet.new([:a, :b, :c]),
      ...>   MapSet.new([
      ...>     MapSet.new([]),
      ...>     MapSet.new([:b]),
      ...>     MapSet.new([:a, :b]),
      ...>     MapSet.new([:a, :b, :c])
      ...>   ])
      ...>  }
      iex> Topology.Neighborhood.is_neighborhood?(topological_space, :a, MapSet.new([:a, :b]))
      true

  """
  def is_neighborhood?({underlying_set, _topology} = topological_space, x, subset) do
    cond do
      not MapSet.member?(x, underlying_set) ->
        {:error, :x_is_not_in_underlying_set}

      not MapSet.subset?(subset, underlying_set) ->
        {:error, :subset_is_not_in_underlying_set}

      true ->
        {:ok,
         subset |> Topology.Operator.interior_operator(topological_space) |> MapSet.member?(x)}
    end
  end
end
