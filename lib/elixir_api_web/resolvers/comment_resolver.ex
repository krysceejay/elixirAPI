defmodule ElixirApiWeb.Resolvers.CommentResolver do
  alias ElixirApi.Blog

  def create_comment(_,%{input: input},%{context: %{current_user: current_user}}) do
    comment_inputs = Map.merge(input, %{user_id: current_user.id})
    
    Blog.create_comment(comment_inputs)
  end

end
