defmodule OneSignalTest do
  use ExUnit.Case
  import Hammox

  alias OneSignal.{
    Request,
    Response,
  }

  describe "create_notifications/3" do
    test "returns an error request is not successful" do
      body_response = %{
        "errors" => ["You must include which players, segments, or tags you wish to send this notification to."]
      }
      mock_client(400, body_response)

      expected_response = {:error, %{
        message: body_response,
        status: 400
      }}
      assert expected_response == OneSignal.create_notifications([], %{en: "test"})
    end

    test "returns body when request is successful" do
      body_response = %{
        "external_id" => nil,
        "id" => "55f563c7-3cd9-4f4a-8b28-e234a00b497c",
        "recipients" => 1
      }
      mock_client(200, body_response)

      assert {:ok, body_response} == OneSignal.create_notifications(["55f563c7-3cd9-4f4a-8b28-e234a00b497c"], %{en: "test"})
    end

    defp mock_client(status, body) do
      ClientMock
      |> expect(:build_client, fn [] -> :client end)
      |> expect(:request, fn :client, %Request{method: :post, url: url} ->
        {:ok,
          %Response{
            status: status,
            method: :post,
            url: url,
            body: body
          }
        }
      end)
    end
  end
end
