# Topology

Returns a topology for a given set.

[![hex.pm version](https://img.shields.io/hexpm/v/topology.svg)](https://hex.pm/packages/topology)

```elixir
import Topology

Topology.topology(MapSet.new([:a, :b]))
# => MapSet.new([
#      MapSet.new([MapSet.new([]), MapSet.new([:a, :b, :c])]),
#      MapSet.new([MapSet.new([]), MapSet.new([:a]), MapSet.new([:a, :b, :c])]),
#      MapSet.new([MapSet.new([]), MapSet.new([:b]), MapSet.new([:a, :b, :c])]),
#      ...
#      ...
#      ...
#      MapSet.new([
#        MapSet.new([]),
#        MapSet.new([:a]),
#        MapSet.new([:b]),
#        MapSet.new([:c]),
#        MapSet.new([:a, :b]),
#        MapSet.new([:a, :c]),
#        MapSet.new([:b, :c]),
#        MapSet.new([:a, :b, :c])
#      ])
#    ])
```

Sets must be given as a MapSet.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `topology` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:topology, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/topology>.
