defmodule ElixirApiWeb.Resolvers.CommentResolver do
  alias ElixirApi.Blog

  def create_comment(_,%{input: input},_) do
    comment_inputs = Map.merge(input, %{user_id: 2})
    case Blog.create_comment(comment_inputs) do
      {:ok, comment} ->
        # add this line in
        # Absinthe.Subscription.publish(BookclubWeb.Endpoint, book,
        # new_book: "*"
        # )
        IO.puts("++++++++++++++++++++++++++++")
        IO.inspect(Absinthe.Subscription.publish(ElixirApiWeb.Endpoint, comment, comment_added: "*"))
        Absinthe.Subscription.publish(ElixirApiWeb.Endpoint, comment, comment_added: "*")

        IO.puts("++++++++++++++++++++++++++++")
        {:ok, comment}
        {:error, changeset} -> {:ok, changeset}
      end
  end

end
