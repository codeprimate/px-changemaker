defmodule Pxapp4.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ~w(html)
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ~w(json)
  end

  scope "/", Pxapp4 do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :change
    get "/change", PageController, :change

    get "/api/make", ApiController, :make
  end

  # Other scopes may use custom stacks.
  # scope "/api", Pxapp4 do
  #   pipe_through :api
  # end
end
