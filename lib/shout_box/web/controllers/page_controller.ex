defmodule ShoutBox.Web.PageController do
  use ShoutBox.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
