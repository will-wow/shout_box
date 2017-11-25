defmodule ShoutBox.Web.ShoutControllerTest do
  use ShoutBox.Web.ConnCase
  import Mox

  alias ShoutBox.SocialMedia.TwitterMock

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
    setup [:setup_twitter_mock]
    test "creates shout and redirects to show when data is valid", %{conn: conn} do
      TwitterMock
      |> expect(:fetch_image_url, fn handle ->
        "htts://example.com/#{handle}/image.png"
      end)

      shout_params = %{"username" => "bob", "message" => "I can build it"}
      conn = post conn, shout_path(conn, :create), shout: shout_params

      conn = get conn, shout_path(conn, :index)
      assert html_response(conn, 200) =~ "I can build it"
    end

    test "does not create shout and renders errors when data is invalid", %{conn: conn} do

      conn = post conn, shout_path(conn, :create), shout: @invalid_attrs
      response = html_response(conn, 200)

      assert response =~ "Something went wrong!"
    end
  end

  def setup_twitter_mock(_context) do
    TwitterMock
    |> expect(:fetch_image_url, fn handle ->
      "htts://example.com/#{handle}/image.png"
    end)

    :ok 
  end
end
