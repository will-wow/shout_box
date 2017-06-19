defmodule ShoutBox.Web.ShoutControllerTest do
  use ShoutBox.Web.ConnCase

  alias ShoutBox.Messages

  @create_attrs %{message: "some message", username: "some username"}
  @update_attrs %{message: "some updated message", username: "some updated username"}
  @invalid_attrs %{message: nil, username: nil}

  def fixture(:shout) do
    {:ok, shout} = Messages.create_shout(@create_attrs)
    shout
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, shout_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Shouts"
  end

  test "renders form for new shouts", %{conn: conn} do
    conn = get conn, shout_path(conn, :new)
    assert html_response(conn, 200) =~ "New Shout"
  end

  test "creates shout and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, shout_path(conn, :create), shout: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == shout_path(conn, :show, id)

    conn = get conn, shout_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Shout"
  end

  test "does not create shout and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, shout_path(conn, :create), shout: @invalid_attrs
    assert html_response(conn, 200) =~ "New Shout"
  end

  test "renders form for editing chosen shout", %{conn: conn} do
    shout = fixture(:shout)
    conn = get conn, shout_path(conn, :edit, shout)
    assert html_response(conn, 200) =~ "Edit Shout"
  end

  test "updates chosen shout and redirects when data is valid", %{conn: conn} do
    shout = fixture(:shout)
    conn = put conn, shout_path(conn, :update, shout), shout: @update_attrs
    assert redirected_to(conn) == shout_path(conn, :show, shout)

    conn = get conn, shout_path(conn, :show, shout)
    assert html_response(conn, 200) =~ "some updated message"
  end

  test "does not update chosen shout and renders errors when data is invalid", %{conn: conn} do
    shout = fixture(:shout)
    conn = put conn, shout_path(conn, :update, shout), shout: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Shout"
  end

  test "deletes chosen shout", %{conn: conn} do
    shout = fixture(:shout)
    conn = delete conn, shout_path(conn, :delete, shout)
    assert redirected_to(conn) == shout_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, shout_path(conn, :show, shout)
    end
  end
end
