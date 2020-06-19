defmodule OneSignal do
  @moduledoc """
  Wrapper for the OneSignal REST API.
  """

  alias OneSignal.{
    Client,
    Request,
    Response,
  }

  defdelegate build_client, to: Client

  @doc """
  Sends notifications to your users.

  https://documentation.onesignal.com/reference/create-notification#create-notification
  """
  def create_notification(client, player_ids, contents) do
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

  def config(key), do: Application.get_env(:one_signal, key)
  def config(key, default), do: Application.get_env(:one_signal, key, default)
end
