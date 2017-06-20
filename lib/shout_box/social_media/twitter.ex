defmodule ShoutBox.SocialMedia.Twitter do
  @moduledoc """
  Twitter client
  """
  @twitter_auth Application.get_env(:shout_box, :twitter_auth, TwitterAuth)

  @users_url "https://api.twitter.com/1.1/users/show.json"
  @default_image_url "https://abs.twimg.com/sticky/default_profile_images/default_profile_normal.png"

  alias ShoutBox.SocialMedia.TwitterAuth

  def fetch_image_url(handle, http \\ HTTPoison) do
    user = fetch_user(handle, http)

    if user do
      user["profile_image_url_https"]
    else
      @default_image_url
    end
  end

  def fetch_user(handle, http \\ HTTPoison) do
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
