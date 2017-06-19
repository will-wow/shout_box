defmodule ShoutBox.Factory do
  @moduledoc """
  Sets up db factories
  """
  alias ShoutBox.Repo

  alias ShoutBox.Messages.Shout

  def build(:shout) do
    %Shout{username: "jen", message: "hello world"}
  end

  # def build(:user) do
  #   %User{username: "jen"}
  # end

  # def with_user(%Shout{} = shout) do
  #   %Shout{shout | user: build(:user)}
  # end

  def build(factory_name, attributes) do
    factory_name |> build() |> struct(attributes)
  end

  def insert!(struct) when is_map(struct), do: Repo.insert!(struct)
  def insert!(factory_name, attributes \\ []) do
    Repo.insert! build(factory_name, attributes)
  end
end
