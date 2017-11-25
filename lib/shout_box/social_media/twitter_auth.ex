defmodule ShoutBox.SocialMedia.TwitterAuth do
  @moduledoc """
  Fetches bearer tokens
  """

  alias __MODULE__

  @callback start_link() :: {:ok, Agent.on_start}
  @callback bearer_token() :: String.t
  @callback bearer_token() :: String.t

  @http Application.get_env(:shout_box, :http, HTTPoison)

  @secret Application.get_env(:shout_box, __MODULE__)[:consumer_secret]
  @key Application.get_env(:shout_box, __MODULE__)[:consumer_key]
  @credentials Base.encode64("#{@key}:#{@secret}")
  @base_url "https://api.twitter.com"
  @token_url "#{@base_url}/oauth2/token"

  def start_link do
    Agent.start_link(fn -> %{token: nil} end, name: __MODULE__)
  end

  def bearer_token() do
    case Agent.get(__MODULE__, &(&1[:token])) do
      nil ->
        token = fetch_bearer_token()
        put_bearer_token(token)
        token
      token -> token
    end
  end

  defp put_bearer_token(token) do
    Agent.update(__MODULE__, &(%{&1 | token: token}))
  end

  defp fetch_bearer_token() do
    result = @http.post!(
      @token_url,
      "grant_type=client_credentials",
      "Authorization": "Basic #{@credentials}",
      "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8"
    )

    body = result.body
    body = Poison.decode!(body)

    body["access_token"]
  end
end
