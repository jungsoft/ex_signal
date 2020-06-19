# OneSignal

Wrapper for the [OneSignal API](https://documentation.onesignal.com/reference).

## Installation

1. Add one_signal to your list of dependencies in mix.exs:

```elixir
def deps do
  [{:one_signal, "~> 0.1.0"}]
end
```

2. Add this to your config.exs:

```elixir
config :one_signal,
  app_id: "your app id",
  api_key: "your api key"
```

To make testing easier, you can also provide your own OneSignal.Client implementation:

```elixir
# test.exs
config :one_signal, client: ClientMock
```
