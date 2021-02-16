defmodule ExSignal.MixProject do
  use Mix.Project

  @github_url "https://github.com/jungsoft/ex_signal"

  def project do
    [
      app: :ex_signal,
      version: "0.3.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "ex_signal",
      source_url: @github_url,
      description: "Elixir wrapper for the OneSignal API",
      package: package(),
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end


  defp package do
    [
      files: ~w(lib mix.exs README*),
      licenses: ["MIT"],
      links: %{
        "GitHub" => @github_url,
        "Docs" => "https://hexdocs.pm/ex_signal/"
      }
    ]
  end

  defp deps do
    [
      # Tesla
      {:tesla, "~> 1.3.0"},
      {:hackney, "~> 1.16"},
      {:jason, ">= 1.0.0"},
      # Testing
      {:hammox, "~> 0.2", only: :test},
      # Docs
      {:ex_doc, "~> 0.22", only: :dev, runtime: false},
    ]
  end
end
