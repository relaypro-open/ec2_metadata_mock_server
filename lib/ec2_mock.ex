defmodule Ec2Mock do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      {Plug.Cowboy, scheme: :http, plug: Ec2Mock.Ec2InstanceMetadata, options: [port: 3000]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ec2Mock.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
