defmodule Auth.MixProject do
  use Mix.Project

  def project do
    [
      app: :auth,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.12.2",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      xref: [exclude: [PwHelper.Changeset, PwHelper.Hash, PwHelper.Error, PwHelper, Plug.Conn]]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :pw_helper],
      mod: {Auth.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:jason, "~> 1.2"},
      {:joken, "~> 2.5"},
      {:pw_helper, git: "https://github.com/kalachlegends/pw_helper", tag: "0.1.7"},
      {:plug, "~> 1.13"},
      {:plug_cowboy, "~> 2.0"}
    ]
  end
end
