defmodule ExSignal.Client do
  @moduledoc """
  HTTP Client for the OneSignal REST API.

  ## Adapter

  Defaults to OneSginal.Client.Tesla
  To use your own adapter, set it via Mix configuration:

      config :ex_signal, client: ClientMock
  """

  alias ExSignal.{
    Client.Tesla,
    Request,
    Response,
  }

  @type t :: any()
  @type opts :: Keyword.t()
  @type instance_url :: map() | String.t()

  @callback build_client(opts) :: t()
  @callback request(t(), Request.t()) :: {:ok, Response.t()} | {:error, any()}

  defp adapter, do: Application.get_env(:ex_signal, :client) || Tesla

  def build_client(opts \\ []), do: adapter().build_client(opts)

  @doc """
  Sends a request to OneSignal
  """
  def request(client, request), do: adapter().request(client, request)
end
