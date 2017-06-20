defmodule ShoutBox.Test.Mocks.HTTPoison do
  def get!(url, headers, opts \\ []) do
    send self(), {:get!, url, headers, opts}
  end

  def post!(url, body, headers, opts \\ []) do
    send self(), {:post!, url, body, headers, opts}
  end
end