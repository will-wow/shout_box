defmodule ShoutBox.Test.Mocks.HTTPoison do
  def get!(url, headers, opts \\ []) do
    seld self(), {:get!, url, headers, opts}
  end

  def post!(url, body, headers, opts \\ []) do
    seld self(), {:post!, url, body, headers, opts}
  end
end