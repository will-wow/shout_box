defmodule ShoutBox.Accounts do
  @moduledoc """
  The boundary for the Accounts system.
  """

  import Ecto.Query, warn: false
  alias ShoutBox.Repo

  alias ShoutBox.Accounts.User
  alias ShoutBox.SocialMedia.Twitter

  @twitter Application.get_env(:shout_box, :twitter, Twitter)

  @doc """
  Creates a user.
  """
  def create_user(username, twitter \\ @twitter) do
    profile_picture_url = twitter.fetch_image_url(username)

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

