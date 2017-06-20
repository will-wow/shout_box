defmodule ShoutBox.Accounts do
  @moduledoc """
  The boundary for the Accounts system.
  """

  import Ecto.Query, warn: false
  alias ShoutBox.Repo

  alias ShoutBox.Accounts.User
  alias ShoutBox.SocialMedia.Twitter

  @doc """
  Creates a user.
  """
  def create_user(username) do
    profile_picture_url = Twitter.fetch_image_url(username)

    %User{}
    |> User.changeset(%{
      username: username,
      profile_picture_url: profile_picture_url
    })
    |> Repo.insert()
  end

  @doc """
  Finds an existing user, or creates a new one.
  """
  def find_or_create_user(username) do
    case Repo.get_by(User, username: username) do
      nil -> create_user(username)
      user -> {:ok, user}
    end
  end
end

