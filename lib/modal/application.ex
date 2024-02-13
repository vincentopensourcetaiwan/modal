defmodule Modal.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ModalWeb.Telemetry,
      Modal.Repo,
      {DNSCluster, query: Application.get_env(:modal, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Modal.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Modal.Finch},
      # Start a worker by calling: Modal.Worker.start_link(arg)
      # {Modal.Worker, arg},
      # Start to serve requests, typically the last entry
      ModalWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Modal.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ModalWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
