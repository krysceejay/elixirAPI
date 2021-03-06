defmodule ElixirApiWeb.Schema.Types.PostType do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias ElixirApi.Blog

  object :post_type do
  field :id, :id
  field :title, :string
  field :content, :string
  field :published, :boolean
  field :user, :user_type, resolve: dataloader(Blog)
end

input_object :post_input_type do
  field :title, non_null(:string)
  field :content, non_null(:string)
  field :published, non_null(:boolean)
end

end
