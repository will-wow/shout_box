defmodule ShoutBox.SocialMedia.Twitter do
  @moduledoc """
  Twitter client
  """

  @users_url "/users/show"
  @default_image_url "https://abs.twimg.com/sticky/default_profile_images/default_profile_normal.png"

  alias ShoutBox.SocialMedia.TwitterAuth

  def fetch_image_url(handle) do
    user = fetch_user(handle)

    if user do
      user["profile_image_url_https"]
    else
      @default_image_url
    end
  end

  def fetch_user(handle) do
    result =
      HTTPoison.get!(
        TwitterAuth.url(@users_url),
        ["Authorization": "Bearer #{TwitterAuth.bearer_token()}"],
        params: [ screen_name: handle ],
      )

    body = result.body
    body = Poison.decode!(body)
  end

end