defmodule ExSignal.Client.Tesla do
  @moduledoc false

  @behaviour ExSignal.Client

  alias ExSignal.{
    Request,
    Response,
  }

  @impl true
  def build_client(opts \\ []) do
    timeout = Keyword.get(opts, :timeout, 30_000)
    api_key = Keyword.get(opts, :api_key, ExSignal.config(:api_key))

    middleware = [
      {Tesla.Middleware.BaseUrl, ExSignal.config(:api_url, "https://onesignal.com/api/v1")},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers, [{"Authorization", "Basic #{api_key}"}]},
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
end
