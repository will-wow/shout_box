defmodule ShoutBox.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:accounts_users) do
      add :username, :string
      add :profile_picture_url, :string

      timestamps()
    end

    alter table(:messages_shouts) do
      remove :username
      add :user_id, references(:accounts_users)
    end
  end
end
