defmodule Topology.InteriorTest do
  use ExUnit.Case
  import Topology.Interior
  doctest Topology.Interior

  setup_all do
    {
      :ok,
      topological_space: {
        MapSet.new([:a, :b, :c]),
        MapSet.new([
          MapSet.new([]),
          MapSet.new([:b]),
          MapSet.new([:a, :b]),
          MapSet.new([:a, :b, :c])
        ])
      },
      m: MapSet.new([:a, :b])
    }
  end

  describe "be sufficient to four theorem" do
    test "first", state do
      assert interior_operator(state[:m], state[:topological_space]) === state[:m]
    end

    test "second", state do
      assert state[:m]
             |> Set.power_set()
             |> Enum.all?(fn m ->
               MapSet.subset?(interior_operator(m, state[:topological_space]), m)
             end)
    end

    test "third", state do
      assert state[:m]
             |> Set.power_set()
             |> Enum.all?(fn m ->
               state[:m]
               |> Set.power_set()
               |> Enum.all?(fn n ->
                 MapSet.intersection(
                   interior_operator(m, state[:topological_space]),
                   interior_operator(n, state[:topological_space])
                 ) ===
                   interior_operator(MapSet.intersection(m, n), state[:topological_space])
               end)
             end)
    end

    test "fourth", state do
      assert state[:m]
             |> Set.power_set()
             |> Enum.all?(
               &(interior_operator(
                   interior_operator(&1, state[:topological_space]),
                   state[:topological_space]
                 ) ===
                   interior_operator(&1, state[:topological_space]))
             )
    end
  end
end
