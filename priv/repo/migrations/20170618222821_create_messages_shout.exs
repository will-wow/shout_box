defmodule ShoutBox.Repo.Migrations.CreateShoutBox.Messages.Shout do
  use Ecto.Migration

  def change do
    create table(:messages_shouts) do
      add :username, :string
      add :message, :string

      timestamps()
    end

  end
end
