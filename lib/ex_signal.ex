defmodule ExSignal do
  @moduledoc """
  Wrapper for the OneSignal REST API.

  ## Installation

  1. Add ex_signal to your list of dependencies in mix.exs:

  ```
  def deps do
    [{:ex_signal, "~> 0.1.0"}]
  end
  ```

  2. Add this to your config.exs:

  ```
  config :ex_signal,
    app_id: "your app id",
    api_key: "your api key"
  ```

  To make testing easier, you can also provide your own `ExSignal.Client` implementation:

  ```
  # test.exs
  config :ex_signal, client: ClientMock
  ```
  """

  alias ExSignal.{
    Client,
    Request,
    Response,
  }

  defdelegate build_client(opts \\ []), to: Client

  @doc """
  Sends notifications to your users.

  https://documentation.onesignal.com/reference/create-notification#create-notification
  """
  def create_notifications(player_ids, contents, client \\ build_client()) do
    body = %{
      app_id: config(:app_id),
      include_player_ids: player_ids,
      contents: contents,
    }

    client
    |> Client.request(%Request{method: :post, url: "/notifications", body: body})
    |> handle_response()
  end

  defp handle_response({:ok, %Response{status: 200, body: body}}), do: {:ok, body}
  defp handle_response({:ok, %Response{status: status, body: body}}), do: {:error, %{status: status, message: body}}
  defp handle_response({:error, _} = error), do: error

  def config(key), do: Application.get_env(:ex_signal, key)
  def config(key, default), do: Application.get_env(:ex_signal, key, default)
end
