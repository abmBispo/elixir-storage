defmodule ElixirStorage.RegistryTest do
  use ExUnit.Case, async: true

  alias ElixirStorage.{
    Registry,
    Bucket
  }

  setup(context) do
    _ = start_supervised!({Registry, name: context.test})
    %{registry: context.test}
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
    _ = Registry.create(registry, "bogus")
    assert Registry.lookup(registry, "shopping") == :error
  end

  test "removes buckets on crash", %{registry: registry} do
    Registry.create(registry, "shopping")
    {:ok, bucket} = Registry.lookup(registry, "shopping")
    Agent.stop(bucket, :shutdown)
    _ = Registry.create(registry, "bogus")
    assert Registry.lookup(registry, "shopping") == :error
  end

  test "bucket can crash at any time", %{registry: registry} do
    Registry.create(registry, "shopping")
    {:ok, bucket} = Registry.lookup(registry, "shopping")
    # Simulate a bucket crash by explicitly and synchronously shutting it down
    Agent.stop(bucket, :shutdown)
    # Now trying to call the dead process causes a :noproc exit
    catch_exit(Bucket.put(bucket, "milk", 3))
  end
end
