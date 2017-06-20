defmodule ShoutBox.MessagesTest do
  use ExUnit.Case, async: true

  alias ShoutBox.SocialMedia.TwitterAuth

  defmodule MockHTTPoison do
    def post!(url, body, headers) do
      send self(), {:post!, url, body, headers}

      %HTTPoison.Response{
        body: Poison.encode!(%{access_token: "abc"})
      }
    end
  end

  setup do
    # Clear the Agent for each test.
    Agent.update(TwitterAuth, fn _ -> %{token: nil} end)
  end

  test "getting a new bearer token" do
    credentials = Base.encode64("twitter_key:twitter_secret")
    basic_credentials = "Basic #{credentials}"

    assert TwitterAuth.bearer_token(MockHTTPoison) == "abc"
    assert_received {
      :post!, 
      "https://api.twitter.com/oauth2/token",
      "grant_type=client_credentials",
      "Authorization": basic_credentials,
      "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8"
    }
  end

  test "not re-fetching a stored bearer token" do
    # Correct token returned twice
    assert TwitterAuth.bearer_token(MockHTTPoison) == "abc"
    assert TwitterAuth.bearer_token(MockHTTPoison) == "abc"

    # API only called once
    assert_received { :post!, _, _, _}
    refute_received { :post!, _, _, _}
  end
end