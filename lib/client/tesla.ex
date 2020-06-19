defmodule OneSignal.Client.Tesla do
  @moduledoc false

  @behaviour OneSignal.Client

  alias OneSignal.{
    Request,
    Response,
  }

  @impl true
  def build_client(opts \\ []) do
    timeout = Keyword.get(opts, :timeout, 30_000)

    middleware = [
      {Tesla.Middleware.BaseUrl, config(:api_url)},
      Tesla.Middleware.JSON,
    ]
    adapter = {Tesla.Adapter.Hackney, [recv_timeout: timeout]}

    Tesla.client(middleware, adapter)
  end

  @impl true
  def request(%Tesla.Client{} = client, %Request{} = request) do
    client
    |> Tesla.request(cast_tesla_request(request))
    |> cast_response()
  end

  defp cast_tesla_request(%Request{} = request) do
    request
    |> convert_struct(Tesla.Env)
    |> Map.to_list()
    |> Enum.reject(fn {_key, value} -> is_nil(value) end)
  end

  defp convert_struct(%_struct{} = fields, new_struct), do: struct(new_struct, Map.from_struct(fields))

  defp cast_response({:ok, %Tesla.Env{} = response}), do: {:ok, convert_struct(response, Response)}
  defp cast_response({:error, error}), do: {:error, error}

  defp config(key), do: Application.get_env(:one_signal, key)
end
