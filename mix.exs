defmodule Janrain.Mixfile do
  use Mix.Project

  def project do
    [app: :janrain,
     version: "0.0.1",
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description,
     package: package,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  defp deps do
    [
      {:httpoison, "~> 0.8.0"},
    ]
  end

  defp description do
    """
    A small library to help with Janrain logins. Probably most useful when used in conjuction with Phoenix and Guardian.
    """
  end

  defp package do
    [ # These are the default files included in the package
      files: ["lib", "priv", "mix.exs", "README*", "readme*", "LICENSE*", "license*"],
      maintainers: ["Rick Rein"],
      licenses: ["MIT"],
      links: %{"GitHub": "https://github.com/rickr/janrain"}
    ]
  end
end
