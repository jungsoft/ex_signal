# ExSignal

Elixir wrapper for the [OneSignal API](https://documentation.onesignal.com/reference).

Documentation can be found at [https://hexdocs.pm/ex_signal](https://hexdocs.pm/ex_signal).

## Installation

1. Add ex_signal to your list of dependencies in mix.exs:

```elixir
def deps do
  [{:ex_signal, "~> 0.3.0"}]
end
```

2. Add this to your config.exs:

```elixir
config :ex_signal,
  app_id: "your app id",
  api_key: "your api key"
```

To make testing easier, you can also provide your own `ExSignal.Client` implementation:

```elixir
# test.exs
config :ex_signal, client: ClientMock
```
