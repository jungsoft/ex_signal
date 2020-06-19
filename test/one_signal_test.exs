defmodule OneSignalTest do
  use ExUnit.Case
  import Hammox

  alias OneSignal.{
    Request,
    Response,
  }

  describe "create_notifications/3" do
    test "returns an error when player_ids is empty" do
      ClientMock
      |> expect(:build_client, fn [] -> :client end)
      |> expect(:request, fn :client, %Request{method: :post, url: url} ->
        {:ok,
          %Response{
            status: 400,
            method: :post,
            url: url,
            body: %{
              "errors" => ["You must include which players, segments, or tags you wish to send this notification to."]
            },
          }
        }
      end)

      expected_response = {:error, %{
        message: %{
          "errors" => ["You must include which players, segments, or tags you wish to send this notification to."]
        },
        status: 400
      }}

      assert expected_response == OneSignal.create_notifications([], %{en: "Oi"})
    end
  end
end
