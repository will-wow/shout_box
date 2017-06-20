defmodule ShoutBox.Messages do
  @moduledoc """
  The boundary for the Messages system.
  """

  import Ecto.Query, warn: false
  alias ShoutBox.Repo

  alias ShoutBox.Messages.Shout

  @doc """
  Returns the list of shouts.

  ## Examples

      iex> list_shouts()
      [%Shout{}, ...]

  """
  def list_shouts do
    Repo.all(from s in Shout, preload: :user)
  end

  @doc """
  Gets a single shout.

  Raises `Ecto.NoResultsError` if the Shout does not exist.

  ## Examples

      iex> get_shout!(123)
      %Shout{}

      iex> get_shout!(456)
      ** (Ecto.NoResultsError)

  """
  def get_shout!(id) do
    Shout
    |> Repo.get!(id) 
    |> Repo.preload(:user)
  end

  @doc """
  Creates a shout.

  ## Examples

      iex> create_shout(%{field: value})
      {:ok, %Shout{}}

      iex> create_shout(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_shout(message, user) do
    user
    |> Ecto.build_assoc(:shouts)
    |> Shout.changeset(%{message: message})
    |> Repo.insert()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking shout changes.

  ## Examples

      iex> change_shout(shout)
      %Ecto.Changeset{source: %Shout{}}

  """
  def change_shout(%Shout{} = shout) do
    Shout.changeset(shout, %{})
  end
end
