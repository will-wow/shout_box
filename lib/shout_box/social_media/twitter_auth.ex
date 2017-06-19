defmodule ShoutBox.SocialMedia.TwitterAuth do
  @moduledoc """
  Fetches bearer tokens
  """
  @secret Application.get_env(:shout_box, __MODULE__)[:consumer_secret]
  @key Application.get_env(:shout_box, __MODULE__)[:consumer_key]
  @credentials "#{@key}:#{@secret}"
  @base_url "https://api.twitter.com"
  @token_url "#{@base_url}/oauth2/token"

  def start_link do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def bearer_token do
    case Agent.get(__MODULE__, &(&1[:token])) do
      nil ->
        token = fetch_bearer_token()
        put_bearer_token(token)
        token
      token -> token
    end
  end

  def url(path) do
    "#{@base_url}#{path}"
  end

  defp put_bearer_token(token) do
    Agent.update(__MODULE__, &(%{&1 | token: token}))
  end

  defp fetch_bearer_token do
    result = HTTPoison.post!(
      @token_url,
      Poison.encode!(%{body: "grant_type=client_credentials"}),
      "Authorization": "Basic #{@credentials}",
      "Content-Type": "application/x-www-form-urlencoded"
    )

    body = result.body
    body = Poison.decode!(body)

    body["access_token"]
  end
end
