defmodule Set do
  @moduledoc """
  Operations for sets.
  """

  @doc """
  Returns a power set of the given set.

  ## Examples

      iex> Set.power_set(MapSet.new([1, 2, 3]))
      MapSet.new([MapSet.new([]), MapSet.new([1]), MapSet.new([2]), MapSet.new([3]), MapSet.new([1, 2]), MapSet.new([1, 3]), MapSet.new([2, 3]), MapSet.new([1, 2, 3])])

  """
  def power_set(set) do
    set
    |> MapSet.to_list()
    |> power_list
    |> Enum.map(&MapSet.new(&1))
    |> MapSet.new()
  end

  @spec intersection(MapSet.t()) :: MapSet.t()
  @doc """
  Returns a intersection of the given sets.

  ## Examples

      iex> Set.intersection(MapSet.new([MapSet.new([3, 4, 6]), MapSet.new([1, 4, 3]), MapSet.new([5, 2, 3])]))
      MapSet.new([3])

  """
  def intersection(set) do
    set |> Enum.reduce(fn e, acc -> MapSet.intersection(e, acc) end)
  end

  @spec union(MapSet.t()) :: MapSet.t()
  @doc """
  Returns a union of the given sets.

  ## Examples

      iex> Set.union(MapSet.new([MapSet.new([3, 4, 6]), MapSet.new([1, 4, 3]), MapSet.new([5, 2, 3])]))
      MapSet.new([1, 2, 3, 4, 5, 6])

  """
  def union(set) do
    set |> Enum.reduce(fn e, acc -> MapSet.union(e, acc) end)
  end

  @spec function_set(MapSet.t(), MapSet.t()) :: MapSet.t()
  @doc """
  Returns a function set of the given sets.

  ## Examples

      iex> Set.function_set(MapSet.new([:a, :b, :c]), MapSet.new([1, 2, 3]))
      MapSet.new([%{a: 1}, %{a: 2}, %{a: 3}, %{b: 1}, %{b: 2}, %{b: 3}, %{c: 1}, %{c: 2}, %{c: 3}])

  """
  def function_set(domain_set, codomain_set) do
    domain_set
    |> Enum.map(
      fn domain->
        codomain_set
        |> Enum.map(fn codomain -> %{domain => codomain} end)
      end
    )
    |> List.flatten()
    |> MapSet.new()
  end

  defp power_list(list) do
    case list do
      list when length(tl(list)) === 0 ->
        list
        |> hd
        |> (fn e -> [[], [e]] end).()

      [head | tail] ->
        power_list(tail) ++ Enum.map(power_list(tail), &[head | &1])
    end
  end
end
