defmodule ElixirApiWeb.Schema.Types.Usertype do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias ElixirApi.Blog

      object :user_type do
      field :id, :id
      field :first_name, :string
      field :email, :string
      field :last_name, :string
      field :role, :string
      field :posts, list_of(:post_type), resolve: dataloader(Blog)
    end

    input_object :user_input_type do
      field :first_name, non_null(:string)
      field :last_name, non_null(:string)
      field :email, non_null(:string)
      field :passwordfield, non_null(:string)
      field :passwordfield_confirmation, non_null(:string)
    end

end
