defmodule ShoutBox.Test.Mocks.TwitterAuth do
  def start_link do
    seld self(), {:start_link}
  end

  def bearer_token do
    send self(), {:bearer_token}
  end
end
