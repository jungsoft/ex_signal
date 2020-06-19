defmodule OneSignal.Client do
  @moduledoc """
  HTTP Client for the OneSignal REST API.

  ## Adapter

  Defaults to OneSginal.Client.Tesla
  To use your own adapter, set it via Mix configuration:

      config :one_signal, client: ClientMock
  """

  alias OneSignal.{
    Client.Tesla,
    Request,
    Response,
  }

  @type t :: any()
  @type opts :: Keyword.t()
  @type instance_url :: map() | String.t()

  @callback build_client :: t()
  @callback request(t(), Request.t()) :: {:ok, Response.t()} | {:error, any()}

  defp adapter, do: Application.get_env(:one_signal, :client) || Tesla

  def build_client, do: adapter().build_client()

  def request(client, request), do: adapter().request(client, request)
end
