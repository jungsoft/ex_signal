defmodule ExSignal.Request do
  @moduledoc """
  Represents an API request.
  """

  @type t :: %__MODULE__{
    body: any(),
    headers: [{binary(), binary()}] | nil,
    method: :head | :get | :delete | :trace | :options | :post | :put | :patch,
    opts: [any()] | nil,
    query: [{binary() | atom(), binary()}] | nil,
    url: binary()
  }

  defstruct [
    :body,
    :headers,
    :method,
    :opts,
    :query,
    :url
  ]
end
