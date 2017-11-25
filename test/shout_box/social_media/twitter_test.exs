defmodule ShoutBox.SocialMedia.TwitterTest do
  use ExUnit.Case, async: true
  import Mox

  alias ShoutBox.SocialMedia.Twitter
  alias ShoutBox.SocialMedia.TwitterAuthMock
  alias ShoutBox.HTTPoisonMock

  defmodule MockHTTPoison do
    def get!(url, headers, opts) do
      send self(), {:get!, url, headers, opts}

    end
  end

  describe "fetch_user" do
    setup [:mock_twitter_auth, :mock_twitter_user]

    test "hits the twitter API" do
      Twitter.fetch_user("bob")
    end

    test "it returns the user" do
      assert Twitter.fetch_user("bob") == %{
        "profile_image_url_https" => "https://example.com/bob.png"
      }
    end
  end

  describe "fetch_image_url" do
    setup [:mock_twitter_auth, :mock_twitter_user]

    test "returns the user's https image" do
      assert Twitter.fetch_image_url("bob") ==
        "https://example.com/bob.png"
    end
  end

  defp mock_twitter_auth(_context) do
    TwitterAuthMock
    |> expect(:start_link, fn -> {:ok, {}} end)
    |> expect(:bearer_token, fn -> "abc" end)

    :ok
  end

  defp mock_twitter_user(_context) do
    HTTPoisonMock
    |> expect(:get!, fn
      "https://api.twitter.com/1.1/users/show.json",
      [
        "Authorization": "Bearer abc",
        "Content-Type": "application/json"
      ],
      params: [ screen_name: handle ]
    -> 
      %HTTPoison.Response{
        body: Poison.encode!(%{
          profile_image_url_https: "https://example.com/#{handle}.png"
        })
      }
    end)
    :ok
  end
end