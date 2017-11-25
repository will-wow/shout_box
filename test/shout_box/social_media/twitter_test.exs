defmodule ShoutBox.SocialMedia.TwitterTest do
  use ExUnit.Case, async: true
  import Mox

  alias ShoutBox.SocialMedia.Twitter
  alias ShoutBox.SocialMedia.TwitterAuthMock

  defmodule MockHTTPoison do
    def get!(url, headers, opts) do
      send self(), {:get!, url, headers, opts}

      %HTTPoison.Response{
        body: Poison.encode!(%{
          profile_image_url_https: "https://example.com/img.png"
        })
      }
    end
  end

  describe "fetch_user" do
    setup [:mock_twitter_auth]

    test "hits the twitter API" do
      Twitter.fetch_user("bob", MockHTTPoison)

      assert_received {
        :get!, 
        "https://api.twitter.com/1.1/users/show.json",
        [
          "Authorization": "Bearer abc",
          "Content-Type": "application/json"
        ],
        params: [ screen_name: "bob" ]
      }
    end

    test "it returns the user" do
      assert Twitter.fetch_user("bob", MockHTTPoison) == %{
        "profile_image_url_https" => "https://example.com/img.png"
      }
    end
  end

  describe "fetch_image_url" do
    setup [:mock_twitter_auth]

    test "returns the user's https image" do

      assert Twitter.fetch_image_url("bob", MockHTTPoison) ==
        "https://example.com/img.png"
    end
  end

  defp mock_twitter_auth(_context) do
    TwitterAuthMock
    |> expect(:start_link, fn -> {:ok, {}} end)
    |> expect(:bearer_token, fn -> "abc" end)

    :ok
  end
end