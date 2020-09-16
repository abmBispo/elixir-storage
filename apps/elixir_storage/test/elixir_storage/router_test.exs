defmodule ElixirStorage.RouterTest do
  use ExUnit.Case, async: true

  setup_all do
    current = Application.get_env(:elixir_storage, :routing_table)

    Application.put_env(:elixir_storage, :routing_table, [
      {?a..?m, :"foo@alan-rarolabs"},
      {?n..?z, :"bar@alan-rarolabs"}
    ])

    on_exit(fn -> Application.put_env(:elixir_storage, :routing_table, current) end)
  end

  test "route requests across nodes" do
    assert ElixirStorage.Router.route("hello", Kernel, :node, []) == :"foo@alan-rarolabs"
    assert ElixirStorage.Router.route("world", Kernel, :node, []) == :"bar@alan-rarolabs"
  end

  test "raises on unknown entries" do
    assert_raise RuntimeError, ~r/could not find entry/, fn ->
      ElixirStorage.Router.route(<<0>>, Kernel, :node, [])
    end
  end
end
