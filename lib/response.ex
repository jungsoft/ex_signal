defmodule ExSignal.Response do
  @moduledoc """
  Represents an API response.
  """

  @type t :: %__MODULE__{
    body: any(),
    headers: [{binary(), binary()}] | nil,
    method: :head | :get | :delete | :trace | :options | :post | :put | :patch,
    opts: [any()] | nil,
    query: [{binary() | atom(), binary()}] | nil,
    status: integer() | nil,
    url: binary()
  }

  defstruct [
    :body,
    :headers,
    :method,
    :opts,
    :query,
    :status,
    :url
  ]
end
