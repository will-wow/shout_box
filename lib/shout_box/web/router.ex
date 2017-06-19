defmodule ShoutBox.Web.Router do
  use ShoutBox.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ShoutBox.Web do
    pipe_through :browser # Use the default browser stack

    resources  "/", ShoutController, only: [:index, :new, :create, :show]
  end

  # Other scopes may use custom stacks.
  # scope "/api", ShoutBox.Web do
  #   pipe_through :api
  # end
end
