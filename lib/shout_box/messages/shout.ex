defmodule ShoutBox.Messages.Shout do
  use Ecto.Schema
  import Ecto.Changeset

  alias ShoutBox.Messages.Shout
  alias ShoutBox.Accounts.User

  schema "messages_shouts" do
    field :message, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%Shout{} = shout, attrs) do
    shout
    |> cast(attrs, [:message])
    |> validate_required([:message])
  end
end
