defmodule ElixirStorage.BucketTest do
  use ExUnit.Case

  test "are temporary workers" do
    assert Supervisor.child_spec(ElixirStorage.Bucket, []).restart == :temporary
  end
end
