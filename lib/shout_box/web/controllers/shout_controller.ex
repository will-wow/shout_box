defmodule ShoutBox.Web.ShoutController do
  use ShoutBox.Web, :controller

  alias ShoutBox.Messages
  alias ShoutBox.Accounts

  def index(conn, _params) do
    shouts = Messages.list_shouts()
    changeset = Messages.change_shout(%ShoutBox.Messages.Shout{})

    render(conn, "index.html", shouts: shouts, changeset: changeset)
  end

  def create(conn, %{"shout" => shout_params}) do
    username = shout_params["username"]
    message = shout_params["message"]

    with {:ok, user} <- Accounts.find_or_create_user(username),
         {:ok, shount} <- Messages.create_shout(message, user)
    do
      conn
      |> put_flash(:info, "Shout created successfully.")
      |> redirect(to: shout_path(conn, :index))
    else
      {:error, changeset} ->
        IO.inspect changeset
        shouts = Messages.list_shouts()
        changeset = Messages.change_shout(%ShoutBox.Messages.Shout{})

        conn
        |> put_flash(:error, "Something went wrong!")
        |> render("index.html", shouts: shouts, changeset: changeset)
    end
  end
end
