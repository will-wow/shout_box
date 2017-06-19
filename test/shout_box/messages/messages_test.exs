defmodule ShoutBox.MessagesTest do
  use ShoutBox.DataCase

  alias ShoutBox.Messages

  describe "shouts" do
    alias ShoutBox.Messages.Shout

    @valid_attrs %{message: "some message", username: "some username"}
    @update_attrs %{message: "some updated message", username: "some updated username"}
    @invalid_attrs %{message: nil, username: nil}

    def shout_fixture(attrs \\ %{}) do
      {:ok, shout} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Messages.create_shout()

      shout
    end

    test "list_shouts/0 returns all shouts" do
      shout = shout_fixture()
      assert Messages.list_shouts() == [shout]
    end

    test "get_shout!/1 returns the shout with given id" do
      shout = shout_fixture()
      assert Messages.get_shout!(shout.id) == shout
    end

    test "create_shout/1 with valid data creates a shout" do
      assert {:ok, %Shout{} = shout} = Messages.create_shout(@valid_attrs)
      assert shout.message == "some message"
      assert shout.username == "some username"
    end

    test "create_shout/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messages.create_shout(@invalid_attrs)
    end

    test "change_shout/1 returns a shout changeset" do
      shout = shout_fixture()
      assert %Ecto.Changeset{} = Messages.change_shout(shout)
    end
  end
end
