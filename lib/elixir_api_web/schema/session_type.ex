defmodule ElixirApiWeb.Schema.Types.Sessiontype do
  use Absinthe.Schema.Notation

  object :session_type do
  field :token, :string
  field :user, :user_type
end

input_object :session_input_type do
  field :email, non_null(:string)
  field :passwordfield, non_null(:string)
end

end