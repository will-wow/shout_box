defmodule ShoutBox.SocialMedia.TwitterAuthMock do
  alias ShoutBox.SocialMedia.TwitterAuth
  
  def start_link do
    send self(), {:start_link}
    {:ok, TwitterAuth}
  end

  def bearer_token do
    send self(), {:bearer_token}
    "abc"
  end
end
