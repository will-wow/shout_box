defmodule ShoutBox.Web.ShoutController do
  use ShoutBox.Web, :controller

  alias ShoutBox.Messages

  def index(conn, _params) do
    shouts = Messages.list_shouts()
    render(conn, "index.html", shouts: shouts)
  end

  def new(conn, _params) do
    changeset = Messages.change_shout(%ShoutBox.Messages.Shout{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"shout" => shout_params}) do
    case Messages.create_shout(shout_params) do
      {:ok, shout} ->
        conn
        |> put_flash(:info, "Shout created successfully.")
        |> redirect(to: shout_path(conn, :show, shout))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    shout = Messages.get_shout!(id)
    render(conn, "show.html", shout: shout)
  end

  def edit(conn, %{"id" => id}) do
    shout = Messages.get_shout!(id)
    changeset = Messages.change_shout(shout)
    render(conn, "edit.html", shout: shout, changeset: changeset)
  end

  def update(conn, %{"id" => id, "shout" => shout_params}) do
    shout = Messages.get_shout!(id)

    case Messages.update_shout(shout, shout_params) do
      {:ok, shout} ->
        conn
        |> put_flash(:info, "Shout updated successfully.")
        |> redirect(to: shout_path(conn, :show, shout))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", shout: shout, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    shout = Messages.get_shout!(id)
    {:ok, _shout} = Messages.delete_shout(shout)

    conn
    |> put_flash(:info, "Shout deleted successfully.")
    |> redirect(to: shout_path(conn, :index))
  end
end
