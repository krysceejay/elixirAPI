defmodule ElixirApiWeb.Router do
  use ElixirApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug ElixirApiWeb.Plugs.Context
  end

  scope "/api" do
    pipe_through :api

    forward "/graphql", Absinthe.Plug,
    schema: ElixirApiWeb.Schema

    if Mix.env == :dev do
      forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: ElixirApiWeb.Schema,
      socket: ElixirApiWeb.UserSocket,
      interface: :advanced

    end
  end
end
