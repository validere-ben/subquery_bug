defmodule SubqueryBug.Application do
  use Application

  def start(_type, _args) do
    children = [
      SubqueryBug.Repo
    ]

    opts = [
      strategy: :one_for_one,
      name: SubqueryBug.Supervisor
    ]

    Supervisor.start_link(children, opts)
  end
end
