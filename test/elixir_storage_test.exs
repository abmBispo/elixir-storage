defmodule ElixirStorageTest do
  use ExUnit.Case
  doctest ElixirStorage

  test "greets the world" do
    assert ElixirStorage.hello() == :world
  end
end
