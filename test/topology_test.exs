defmodule TopologyTest do
  use ExUnit.Case
  doctest Topology

  test "when cardinality is three" do
    s = [:a, :b, :c] |> MapSet.new()

    topology_of_s =
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

    assert Topology.topology(s) == topology_of_s
    assert Topology.topology(s) |> MapSet.size() == 29
  end
end
