defmodule ShoutBox.SocialMedia.TwitterAuthTest do
  use ExUnit.Case, async: true
  import Mox

  alias ShoutBox.SocialMedia.TwitterAuth
  alias ShoutBox.HTTPoisonMock

  setup [:clear_agent, :expect_one_bearer_token_request]

  test "getting a new bearer token" do
    credentials = Base.encode64("twitter_key:twitter_secret")
    basic_credentials = "Basic #{credentials}"

    assert TwitterAuth.bearer_token() == "abc"
  end

  test "not re-fetching a stored bearer token" do
    # Correct token returned twice
    assert TwitterAuth.bearer_token() == "abc"
    assert TwitterAuth.bearer_token() == "abc"
  end

  defp clear_agent(_context) do
    Agent.update(TwitterAuth, fn _ -> %{token: nil} end)
    :ok
  end

  defp expect_one_bearer_token_request(_context) do
    HTTPoisonMock
    |> expect(:post!, fn 
      "https://api.twitter.com/oauth2/token",
      "grant_type=client_credentials",
      "Authorization": _basic_credentials,
      "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8"
    ->
      %HTTPoison.Response{
        body: Poison.encode!(%{access_token: "abc"})
      }
    end)

    :ok
  end
end