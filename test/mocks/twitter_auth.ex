defmodule ShoutBox.Test.Mocks.TwitterAuth do
  alias ShoutBox.SocialMedia.TwitterAuth
  
  def start_link do
    send self(), {:start_link}
    {:ok, ShoutBox.SocialMedia.TwitterAuth}
  end

  def bearer_token do
    send self(), {:bearer_token}
    "abc"
  end
end
