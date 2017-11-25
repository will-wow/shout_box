defmodule ShoutBox.SocialMedia.Twitter do
  @moduledoc """
  Twitter client
  """
  alias ShoutBox.SocialMedia.TwitterAuth

  @callback fetch_image_url(String.t):: String.t
  @callback fetch_image_url(String.t, HTTPoison):: String.t
  @callback fetch_user(String.t) :: map
  @callback fetch_user(String.t, HTTPoison) :: map

  @twitter_auth Application.get_env(:shout_box, :twitter_auth, TwitterAuth)
  @http Application.get_env(:shout_box, :http, HTTPoison)

  @users_url "https://api.twitter.com/1.1/users/show.json"
  @default_image_url "https://abs.twimg.com/sticky/default_profile_images/default_profile_normal.png"

  def fetch_image_url(handle, http \\ @http) do
    user = fetch_user(handle, http)

    if user && user["profile_image_url_https"] do
      user["profile_image_url_https"]
    else
      @default_image_url
    end
  end

  def fetch_user(handle, http \\ @http) do
    result =
      http.get!(
        @users_url,
        [
          "Authorization": "Bearer #{@twitter_auth.bearer_token()}",
          "Content-Type": "application/json"
        ],
        params: [ screen_name: handle ]
      )

    body = result.body
    body = Poison.decode!(body)
  end
end
