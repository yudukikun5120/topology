defmodule Topology.Operator do
  @moduledoc """
  Operators on topological spaces.

  ## Lemma

  Let $(S, \\mathfrak{O})$ be a topological space and \\(M \\subset S\\) be a subset of \\(S\\) . Then the following statements are equivalent:

  $$
  \\overline{M^c} = (M^{○})^c
  $$
  """

  @spec interior_operator(MapSet.t(), {Topology.underlying_set(), Topology.topology()}) ::
          MapSet.t() | {:error, <<_::368>>}
  @doc """
  Returns a interior of the given set for topological space.

  ## Mathematical expression

  $$
  M^○,\\ M^i
  $$

  ## Theorem

  Interior operator has the following properties:

    1. $$S^○ = S$$
    2. $$M \\in \\mathfrak{P} (S) \\implies M^○ \\subset M$$
    3. $$M, N \\in \\mathfrak{P}(S) \\implies M^○ \\cap N^○ = (M \\cap N)^○$$
    4. $$M \\in \\mathfrak{P}(S) \\implies M^{○○} = M^○$$

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
      iex> Topology.Operator.interior_operator(m, topological_space)
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

  @spec closure_operator(MapSet.t(), {Topology.underlying_set(), Topology.topology()}) ::
          MapSet.t() | {:error, <<_::368>>}
  @doc """
  Returns a closure of the given set for topological space.

  ## Mathematical expression

  $$
  \\overline{M},\\ M^c
  $$

  ## Theorem

  Closure operator has the following properties:

    1. $$\\overline{\\phi} = \\phi$$
    2. $$M \\in \\mathfrak{P} (S) \\implies \\overline{M} \\supset M$$
    3. $$M, N \\in \\mathfrak{P}(S) \\implies \\overline{M} \\cup \\overline{N} = \\overline{M \\cup N}$$
    4. $$M \\in \\mathfrak{P}(S) \\implies \\overline{\\overline{M}} = \\overline{M}$$

  """

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
