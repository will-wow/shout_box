defmodule ShoutBox.Messages.Shout do
  use Ecto.Schema
  import Ecto.Changeset
  alias ShoutBox.Messages.Shout


  schema "messages_shouts" do
    field :message, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(%Shout{} = shout, attrs) do
    shout
    |> cast(attrs, [:username, :message])
    |> validate_required([:username, :message])
  end
end
