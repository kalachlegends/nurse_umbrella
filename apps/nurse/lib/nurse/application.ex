defmodule Nurse.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Nurse.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Nurse.PubSub}
      # Start a worker by calling: Nurse.Worker.start_link(arg)
      # {Nurse.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Nurse.Supervisor)
  end
end
