defmodule Topology.OperatorTest do
  use ExUnit.Case
  import Topology.Operator
  doctest Topology.Operator

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

  describe "open kernels are sufficient to four theorem" do
    test "first", state do
      {
        underlying_set,
        _
      } = state[:topological_space]

      assert interior_operator(underlying_set, state[:topological_space]) === underlying_set
    end

    test "second", state do
      state[:m]
      |> Set.power_set()
      |> Enum.all?(fn m ->
        assert MapSet.subset?(interior_operator(m, state[:topological_space]), m)
      end)
    end

    test "third", state do
      state[:m]
      |> Set.power_set()
      |> Enum.all?(fn m ->
        state[:m]
        |> Set.power_set()
        |> Enum.all?(fn n ->
          assert MapSet.intersection(
                   interior_operator(m, state[:topological_space]),
                   interior_operator(n, state[:topological_space])
                 ) ===
                   interior_operator(MapSet.intersection(m, n), state[:topological_space])
        end)
      end)
    end

    test "fourth", state do
      state[:m]
      |> Set.power_set()
      |> Enum.all?(
        assert &(interior_operator(
                   interior_operator(&1, state[:topological_space]),
                   state[:topological_space]
                 ) ===
                   interior_operator(&1, state[:topological_space]))
      )
    end
  end

  describe "closures are sufficient to four theorem" do
    test "k1", state do
      assert closure_operator(MapSet.new([]), state[:topological_space]) === MapSet.new([])
    end

    test "k2", state do
      state[:m]
      |> Set.power_set()
      |> Enum.all?(&assert MapSet.subset?(&1, closure_operator(&1, state[:topological_space])))
    end

    test "k3", state do
      state[:m]
      |> Set.power_set()
      |> Enum.all?(fn m ->
        state[:m]
        |> Set.power_set()
        |> Enum.all?(fn n ->
          assert MapSet.union(
                   closure_operator(m, state[:topological_space]),
                   closure_operator(n, state[:topological_space])
                 ) ===
                   closure_operator(MapSet.union(m, n), state[:topological_space])
        end)
      end)
    end

    test "k4", state do
      state[:m]
      |> Set.power_set()
      |> Enum.all?(
        assert &(closure_operator(
                   closure_operator(&1, state[:topological_space]),
                   state[:topological_space]
                 ) ===
                   closure_operator(&1, state[:topological_space]))
      )
    end
  end

  describe "the lemma of the relation of closure and open kernel" do
    test "lemma", state do
      {underlying_set, _topology} = state[:topological_space]

      underlying_set
      |> Set.power_set()
      |> Enum.all?(
        &assert closure_operator(
                  MapSet.difference(underlying_set, &1),
                  state[:topological_space]
                ) ===
                  MapSet.difference(
                    underlying_set,
                    interior_operator(&1, state[:topological_space])
                  )
      )
    end
  end
end
