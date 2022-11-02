defmodule TopologyTest do
  use ExUnit.Case
  import Topology
  doctest Topology

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

  test "when cardinality is three" do
    s = [:a, :b, :c] |> MapSet.new()

    topologies_of_s =
      MapSet.new([
        MapSet.new([MapSet.new([]), MapSet.new([:a, :b, :c])]),
        MapSet.new([MapSet.new([]), MapSet.new([:a]), MapSet.new([:a, :b, :c])]),
        MapSet.new([MapSet.new([]), MapSet.new([:b]), MapSet.new([:a, :b, :c])]),
        MapSet.new([MapSet.new([]), MapSet.new([:c]), MapSet.new([:a, :b, :c])]),
        MapSet.new([MapSet.new([]), MapSet.new([:a, :b]), MapSet.new([:a, :b, :c])]),
        MapSet.new([MapSet.new([]), MapSet.new([:a, :c]), MapSet.new([:a, :b, :c])]),
        MapSet.new([MapSet.new([]), MapSet.new([:b, :c]), MapSet.new([:a, :b, :c])]),
        MapSet.new([
          MapSet.new([]),
          MapSet.new([:a]),
          MapSet.new([:a, :b]),
          MapSet.new([:a, :b, :c])
        ]),
        MapSet.new([
          MapSet.new([]),
          MapSet.new([:a]),
          MapSet.new([:a, :c]),
          MapSet.new([:a, :b, :c])
        ]),
        MapSet.new([
          MapSet.new([]),
          MapSet.new([:a]),
          MapSet.new([:b, :c]),
          MapSet.new([:a, :b, :c])
        ]),
        MapSet.new([
          MapSet.new([]),
          MapSet.new([:b]),
          MapSet.new([:a, :b]),
          MapSet.new([:a, :b, :c])
        ]),
        MapSet.new([
          MapSet.new([]),
          MapSet.new([:b]),
          MapSet.new([:a, :c]),
          MapSet.new([:a, :b, :c])
        ]),
        MapSet.new([
          MapSet.new([]),
          MapSet.new([:b]),
          MapSet.new([:b, :c]),
          MapSet.new([:a, :b, :c])
        ]),
        MapSet.new([
          MapSet.new([]),
          MapSet.new([:c]),
          MapSet.new([:a, :b]),
          MapSet.new([:a, :b, :c])
        ]),
        MapSet.new([
          MapSet.new([]),
          MapSet.new([:c]),
          MapSet.new([:a, :c]),
          MapSet.new([:a, :b, :c])
        ]),
        MapSet.new([
          MapSet.new([]),
          MapSet.new([:c]),
          MapSet.new([:b, :c]),
          MapSet.new([:a, :b, :c])
        ]),
        MapSet.new([
          MapSet.new([]),
          MapSet.new([:a]),
          MapSet.new([:b]),
          MapSet.new([:a, :b]),
          MapSet.new([:a, :b, :c])
        ]),
        MapSet.new([
          MapSet.new([]),
          MapSet.new([:a]),
          MapSet.new([:c]),
          MapSet.new([:a, :c]),
          MapSet.new([:a, :b, :c])
        ]),
        MapSet.new([
          MapSet.new([]),
          MapSet.new([:a]),
          MapSet.new([:a, :b]),
          MapSet.new([:a, :c]),
          MapSet.new([:a, :b, :c])
        ]),
        MapSet.new([
          MapSet.new([]),
          MapSet.new([:b]),
          MapSet.new([:c]),
          MapSet.new([:b, :c]),
          MapSet.new([:a, :b, :c])
        ]),
        MapSet.new([
          MapSet.new([]),
          MapSet.new([:b]),
          MapSet.new([:a, :b]),
          MapSet.new([:b, :c]),
          MapSet.new([:a, :b, :c])
        ]),
        MapSet.new([
          MapSet.new([]),
          MapSet.new([:c]),
          MapSet.new([:a, :c]),
          MapSet.new([:b, :c]),
          MapSet.new([:a, :b, :c])
        ]),
        MapSet.new([
          MapSet.new([]),
          MapSet.new([:a]),
          MapSet.new([:b]),
          MapSet.new([:a, :b]),
          MapSet.new([:a, :c]),
          MapSet.new([:a, :b, :c])
        ]),
        MapSet.new([
          MapSet.new([]),
          MapSet.new([:a]),
          MapSet.new([:b]),
          MapSet.new([:a, :b]),
          MapSet.new([:b, :c]),
          MapSet.new([:a, :b, :c])
        ]),
        MapSet.new([
          MapSet.new([]),
          MapSet.new([:a]),
          MapSet.new([:c]),
          MapSet.new([:a, :b]),
          MapSet.new([:a, :c]),
          MapSet.new([:a, :b, :c])
        ]),
        MapSet.new([
          MapSet.new([]),
          MapSet.new([:a]),
          MapSet.new([:c]),
          MapSet.new([:a, :c]),
          MapSet.new([:b, :c]),
          MapSet.new([:a, :b, :c])
        ]),
        MapSet.new([
          MapSet.new([]),
          MapSet.new([:b]),
          MapSet.new([:c]),
          MapSet.new([:a, :b]),
          MapSet.new([:b, :c]),
          MapSet.new([:a, :b, :c])
        ]),
        MapSet.new([
          MapSet.new([]),
          MapSet.new([:b]),
          MapSet.new([:c]),
          MapSet.new([:a, :c]),
          MapSet.new([:b, :c]),
          MapSet.new([:a, :b, :c])
        ]),
        MapSet.new([
          MapSet.new([]),
          MapSet.new([:a]),
          MapSet.new([:b]),
          MapSet.new([:c]),
          MapSet.new([:a, :b]),
          MapSet.new([:a, :c]),
          MapSet.new([:b, :c]),
          MapSet.new([:a, :b, :c])
        ])
      ])

    assert topologies(s) == topologies_of_s
    assert topologies(s) |> MapSet.size() == 29
  end

  describe "closed sets are sufficient to three theorem" do
    test "first", state do
      {underlying_set, _} = state[:topological_space]
      closed_set_system = closed_set_system(state[:topological_space])

      assert MapSet.member?(closed_set_system, underlying_set) &&
               MapSet.member?(closed_set_system, MapSet.new([]))
    end

    test "second", state do
      closed_set_system = closed_set_system(state[:topological_space])

      assert Enum.all?(closed_set_system, fn set ->
               Enum.all?(closed_set_system, fn other_set ->
                 MapSet.union(set, other_set) |> then(&MapSet.member?(closed_set_system, &1))
               end)
             end)
    end

    test "third", state do
      closed_set_system = closed_set_system(state[:topological_space])

      assert Enum.all?(closed_set_system, fn set ->
               Enum.all?(closed_set_system, fn other_set ->
                 MapSet.intersection(set, other_set)
                 |> then(&MapSet.member?(closed_set_system, &1))
               end)
             end)
    end
  end
end
