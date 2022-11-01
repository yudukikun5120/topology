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

  @doc """
  Returns a intersection of the given sets.

  ## Examples

      iex> Set.intersection(MapSet.new([MapSet.new([3, 4, 6]), MapSet.new([1, 4, 3]), MapSet.new([5, 2, 3])]))
      MapSet.new([3])

  """
  def intersection(set) do
    set |> Enum.reduce(fn e, acc -> MapSet.intersection(e, acc) end)
  end

  def union(set) do
    set |> Enum.reduce(fn e, acc -> MapSet.union(e, acc) end)
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
