defmodule ElixirApiWeb.Schema do
  use Absinthe.Schema

  alias ElixirApiWeb.Schema.Types
  alias ElixirApiWeb.Resolvers
  alias ElixirApiWeb.Schema.Middleware
  alias ElixirApi.Blog
  #import Types
  import_types Types

  def context(ctx) do
  loader =
    Dataloader.new
    |> Dataloader.add_source(Blog, Blog.data())

  Map.put(ctx, :loader, loader)
  end

#   def context(ctx) do
#   default_params = Map.take(ctx, [:current_user])
#   source = Whatever.data(default_params)
#   Dataloader.new |> Dataloader.add_source(...)
#   Map.put(ctx, :loader, dataloader)
# end

def plugins do
  [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
end

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

    @desc "Create post"
    field :create_post, type: :post_type do
      arg :input, non_null(:post_input_type)
      middleware Middleware.Authorize, :any
      resolve &Resolvers.PostResolver.create_post/3
    end

    @desc "Create comment"
    field :create_comment, type: :comment_type do
      arg :input, non_null(:comment_input_type)
      middleware Middleware.Authorize, :any
      resolve &Resolvers.CommentResolver.create_comment/3
    end

  end
  #
  # subscription do
  #
  # end
end
