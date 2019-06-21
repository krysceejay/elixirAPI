defmodule ElixirApi.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias ElixirApi.Accounts.User

  schema "posts" do
    field :title, :string
    field :content, :string
    field :published, :boolean, default: false
    belongs_to :user, User
    #field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :published, :user_id])
    |> validate_required([:title, :content, :published, :user_id])
  end
end
