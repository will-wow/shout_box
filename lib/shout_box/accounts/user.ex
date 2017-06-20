defmodule ShoutBox.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias ShoutBox.Accounts.User
  alias ShoutBox.Messages.Shout

  schema "accounts_users" do
    field :username, :string
    field :profile_picture_url, :string
    has_many :shouts, Shout

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :profile_picture_url])
    |> validate_required([:username, :profile_picture_url])
  end
end

