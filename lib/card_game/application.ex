defmodule CardGame.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CardGameWeb.Telemetry,
      CardGame.Repo,
      {DNSCluster, query: Application.get_env(:card_game, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: CardGame.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: CardGame.Finch},
      # Start a worker by calling: CardGame.Worker.start_link(arg)
      # {CardGame.Worker, arg},
      # Start to serve requests, typically the last entry
      CardGameWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CardGame.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CardGameWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
