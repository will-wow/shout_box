defmodule ShoutBox.Messages.NewShout do
  use Ecto.Schema
  import Ecto.Changeset
  alias ShoutBox.Messages.NewShout

  embedded_schema do
    field :message, :string
    field :username, :string
  end

  @doc false
  def changeset(%NewShout{} = shout, attrs) do
    shout
    |> cast(attrs, [:username, :message])
    |> validate_required([:username, :message])
  end
end

