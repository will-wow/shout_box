defmodule ShoutBox.Messages do
  @moduledoc """
  The boundary for the Messages system.
  """

  import Ecto.Query, warn: false
  alias ShoutBox.Repo

  alias ShoutBox.Messages.Shout

  def list_shouts do
    Repo.all(from s in Shout, preload: :user)
  end

  def get_shout!(id) do
    Shout
    |> Repo.get!(id) 
    |> Repo.preload(:user)
  end

  def create_shout(message, user) do
    user
    |> Ecto.build_assoc(:shouts)
    |> Shout.changeset(%{message: message})
    |> Repo.insert()
  end

  def change_shout(%Shout{} = shout) do
    Shout.changeset(shout, %{})
  end
end
