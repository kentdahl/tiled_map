defmodule TiledMap.Mixfile do
  use Mix.Project

  def project do
    [app: :tiled_map,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded:  Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: "Basic parsing of JSON Map Format from Tiled map editor",
     package: package,
     deps: deps]
  end

  def package do
    [
      maintainers: ["Kent Dahl"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/kentdahl/tiled_map"}
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: []]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:poison, "~> 2.0"}
    ]
  end
end
