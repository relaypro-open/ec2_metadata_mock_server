defmodule Ec2Mock.MixProject do
  use Mix.Project

  def project do
    [
      app: :ec2_mock,
      version: "1.0.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: [{:ec2_mock, release()}]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Ec2Mock, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:json, "~> 1.4"},
      {:bakeware, "~> 0.2.4", runtime: false},
      {:nested, "~> 0.1.2"}
    ]
  end

  defp release do
    [
      overwrite: true,
      quiet: false,
      steps: [:assemble, &Bakeware.assemble/1],
      bakeware: [
        compression_level: 1,
        start_command: "daemon"
      ]
    ]
  end
end
