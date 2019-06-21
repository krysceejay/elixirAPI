defmodule ElixirApiWeb.Schema do
  use Absinthe.Schema

  alias ElixirApiWeb.Schema.Types
  alias ElixirApiWeb.Resolvers
  alias ElixirApiWeb.Schema.Middleware
  #import Types
  import_types Types

  query do

    @desc "Get all users"
    field :users, list_of(:user_type) do
      #Resolver
      middleware Middleware.Authorize, :any
      resolve &Resolvers.UserResolver.users/3
    end

  end

  mutation do
    @desc "Register user"
    field :register_user, type: :user_type do
      arg :input, non_null(:user_input_type)
      resolve &Resolvers.UserResolver.register_user/3
    end

    @desc "Login a user and return JWT token"
    field :login_user, type: :session_type do
      arg :input, non_null(:session_input_type)
      resolve &Resolvers.SessionResolver.login_user/3
    end

  end
  #
  # subscription do
  #
  # end
end
