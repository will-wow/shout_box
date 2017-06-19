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
    Repo.all(Shout)
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
  def get_shout!(id), do: Repo.get!(Shout, id)

  @doc """
  Creates a shout.

  ## Examples

      iex> create_shout(%{field: value})
      {:ok, %Shout{}}

      iex> create_shout(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_shout(attrs \\ %{}) do
    %Shout{}
    |> Shout.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a shout.

  ## Examples

      iex> update_shout(shout, %{field: new_value})
      {:ok, %Shout{}}

      iex> update_shout(shout, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_shout(%Shout{} = shout, attrs) do
    shout
    |> Shout.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Shout.

  ## Examples

      iex> delete_shout(shout)
      {:ok, %Shout{}}

      iex> delete_shout(shout)
      {:error, %Ecto.Changeset{}}

  """
  def delete_shout(%Shout{} = shout) do
    Repo.delete(shout)
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
