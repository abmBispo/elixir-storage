defmodule ElixirStorage do
  use Application

  @impl true
  def start(_type, _args) do
    ElixirStorage.Supervisor.start_link(name: ElixirStorage.Supervisor)
  end  
end
