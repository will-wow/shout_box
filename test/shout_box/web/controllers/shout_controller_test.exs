defmodule ShoutBox.Web.ShoutControllerTest do
  use ShoutBox.Web.ConnCase

  alias ShoutBox.Messages

  @invalid_attrs %{message: "", username: ""}

  describe "#index" do
    test "lists all entries on index", %{conn: conn} do
      :shout |> build(shout: "hello") |> with_user() |> insert!()
      :shout |> build(shout: "hi") |> with_user() |> insert!()

      conn = get conn, shout_path(conn, :index)
      response = html_response(conn, 200)

      assert response =~ "Shoutbox"
      assert response =~ "hello"
      assert response =~ "hi"
    end
  end

  describe "#create" do
    test "creates shout and redirects to show when data is valid", %{conn: conn} do
      shout_params = %{"username" => "bob", "message" => "I can build it"}
      conn = post conn, shout_path(conn, :create), shout: shout_params

      expect_received {:twitter_fetch_url, "bob"}

      conn = get conn, shout_path(conn, :index)
      assert html_response(conn, 200) =~ "I can build it"
    end

    test "does not create shout and renders errors when data is invalid", %{conn: conn} do
      conn = post conn, shout_path(conn, :create), shout: @invalid_attrs
      response = html_response(conn, 200)

      assert response =~ "Something went wrong!"
    end
  end
end
