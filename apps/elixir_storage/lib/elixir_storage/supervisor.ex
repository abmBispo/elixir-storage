defmodule ElixirStorage.Supervisor do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  def init(:ok) do
    children = [
      {DynamicSupervisor, name: ElixirStorage.BucketSupervisor, strategy: :one_for_one},
      {ElixirStorage.Registry, name: ElixirStorage.Registry},
      {Task.Supervisor, name: ElixirStorage.RouterTasks}
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end
end
