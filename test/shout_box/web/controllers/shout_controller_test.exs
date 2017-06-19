defmodule ShoutBox.Web.ShoutControllerTest do
  use ShoutBox.Web.ConnCase

  alias ShoutBox.Messages

  @invalid_attrs %{message: nil, username: nil}

  describe "#index" do
    test "lists all entries on index", %{conn: conn} do
      :shout |> build(shout: "hello") |> insert!()
      :shout |> build(shout: "hi") |> insert!()

      conn = get conn, shout_path(conn, :index)
      response = html_response(conn, 200)

      assert response =~ "Shoutbox"
      assert response =~ "hello"
      assert response =~ "hi"
    end
  end

  describe "#create" do
    test "creates shout and redirects to show when data is valid", %{conn: conn} do
      shout = build(:shout, message: "howdy")
      conn = post conn, shout_path(conn, :create), shout: Map.from_struct(shout)

      assert redirected_to(conn) == shout_path(conn, :index)

      conn = get conn, shout_path(conn, :index)
      assert html_response(conn, 200) =~ "howdy"
    end

    test "does not create shout and renders errors when data is invalid", %{conn: conn} do
      conn = post conn, shout_path(conn, :create), shout: @invalid_attrs
      response = html_response(conn, 200)

      assert response =~ "Please check the errors below."
      # HTML for "can't"
      assert response =~ "can&#39;t be blank"
    end
  end
end
