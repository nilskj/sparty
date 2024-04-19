defmodule Modermodemet.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ModermodemetWeb.Telemetry,
      Modermodemet.Repo,
      {DNSCluster, query: Application.get_env(:modermodemet, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Modermodemet.PubSub},
      ModermodemetWeb.Presence,
      # Start the Finch HTTP client for sending emails
      {Finch, name: Modermodemet.Finch},
      # Start a worker by calling: Modermodemet.Worker.start_link(arg)
      # {Modermodemet.Worker, arg},
      # Start to serve requests, typically the last entry
      ModermodemetWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Modermodemet.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ModermodemetWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
