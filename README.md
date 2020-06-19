# ExSignal

Wrapper for the [OneSignal API](https://documentation.onesignal.com/reference).

## Installation

1. Add ex_signal to your list of dependencies in mix.exs:

```elixir
def deps do
  [{:ex_signal, "~> 0.1.0"}]
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
