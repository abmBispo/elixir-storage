defmodule ElixirStorage.RegistryTest do
  use ExUnit.Case, async: true

  alias ElixirStorage.{
    Registry,
    Bucket
  }

  setup do
    registry = start_supervised!(Registry)
    %{registry: registry}
  end

  test "spawns buckets", %{registry: registry} do
    assert Registry.lookup(registry, "shopping") == :error
    Registry.create(registry, "shopping")
    assert {:ok, shopping_bucket} = Registry.lookup(registry, "shopping")
    Bucket.put(shopping_bucket, "milk", 1)
    assert Bucket.get(shopping_bucket, "milk") == 1
  end

  test "removes buckets on exit", %{registry: registry} do
    Registry.create(registry, "shopping")
    {:ok, bucket} = Registry.lookup(registry, "shopping")
    Agent.stop(bucket)
    assert Registry.lookup(registry, "shopping") == :error
  end
end
