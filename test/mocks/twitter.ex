defmodule ShoutBox.Test.Mocks.Twitter do
  alias ShoutBox.SocialMedia.Twitter
  
  def fetch_image_url(handle) do
    send self(), {:twitter_fetch_image_url, handle}
    "htts://example.com/#{handle}/image.png"
  end

  def fetch_user(handle) do
    send self(), {:twitter_fetch_user, handle}
    "jen"
  end
end
