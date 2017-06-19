defmodule ShoutBox.Web.ShoutController do
  use ShoutBox.Web, :controller

  alias ShoutBox.Messages

  def index(conn, _params) do
    shouts = Messages.list_shouts()
    changeset = Messages.change_shout(%ShoutBox.Messages.Shout{})

    render(conn, "index.html", shouts: shouts, changeset: changeset)
  end

  def create(conn, %{"shout" => shout_params}) do
    case Messages.create_shout(shout_params) do
      {:ok, shout} ->
        conn
        |> put_flash(:info, "Shout created successfully.")
        |> redirect(to: shout_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        shouts = Messages.list_shouts()
        render(conn, "index.html", shouts: shouts, changeset: changeset)
    end
  end
end
