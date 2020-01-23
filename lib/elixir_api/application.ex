defmodule ElixirApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    import Supervisor.Spec
    children = [
      # Start the Ecto repository
      ElixirApi.Repo,
      # Start the endpoint when the application starts
      ElixirApiWeb.Endpoint,
      # Starts a worker by calling: ElixirApi.Worker.start_link(arg)
      # {ElixirApi.Worker, arg},
      {Absinthe.Subscription, [ElixirApiWeb.Endpoint]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ElixirApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
