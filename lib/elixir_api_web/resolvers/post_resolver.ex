defmodule ElixirApiWeb.Resolvers.PostResolver do
  alias ElixirApi.Blog

  # def users(_,_,%{context: context}) do
  #   IO.inspect(context)
  # {:ok, Accounts.list_users()}
  # end

  def create_post(_,%{input: input},%{context: %{current_user: current_user}}) do
    post_inputs = Map.merge(input, %{user_id: current_user.id})
    #IO.inspect(post_inputs)
    Blog.create_post(post_inputs)
  end

end
