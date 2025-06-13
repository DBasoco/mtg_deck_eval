defmodule MtgDeckEval.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MtgDeckEvalWeb.Telemetry,
      MtgDeckEval.Repo,
      {DNSCluster, query: Application.get_env(:mtg_deck_eval, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MtgDeckEval.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: MtgDeckEval.Finch},
      # Start a worker by calling: MtgDeckEval.Worker.start_link(arg)
      # {MtgDeckEval.Worker, arg},
      # Start to serve requests, typically the last entry
      MtgDeckEvalWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MtgDeckEval.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MtgDeckEvalWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
