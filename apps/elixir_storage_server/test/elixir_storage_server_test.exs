defmodule ElixirStorageServerTest do
  use ExUnit.Case
  doctest ElixirStorageServer

  test "greets the world" do
    assert ElixirStorageServer.hello() == :world
  end
end
