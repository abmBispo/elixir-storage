defmodule ElixirStorageTest do
  use ExUnit.Case
  doctest ElixirStorage
  alias ElixirStorage.Bucket

  setup do
    bucket = start_supervised!(Bucket)
    %{bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
    assert Bucket.get(bucket, "milk") == nil

    Bucket.put(bucket, "milk", 3)
    assert Bucket.get(bucket, "milk") == 3
  end

  test "deletes stored keys", %{bucket: bucket} do
    Bucket.put(bucket, "bananas", 55)

    assert Bucket.delete(bucket, "bananas") == 55
    assert Bucket.delete(bucket, "bananas") == nil
  end
end
