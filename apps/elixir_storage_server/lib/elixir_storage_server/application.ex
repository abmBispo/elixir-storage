defmodule ElixirStorageServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Task.Supervisor, name: ElixirStorageServer.TaskSupervisor},
      {Task, fn -> ElixirStorageServer.accept(4040) end}
    ]

    opts = [strategy: :one_for_one, name: ElixirStorageServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
