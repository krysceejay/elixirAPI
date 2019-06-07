defmodule ElixirApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string, unique: true
    field :first_name, :string
    field :last_name, :string
    field :password, :string
    field :passwordtxt, :string, virtual: true
    field :passwordtxt_confirmation, :string, virtual: true
    field :role, :string, default: "user"

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :passwordtxt,:passwordtxt_confirmation, :role])
    |> validate_required([:first_name, :last_name, :email, :passwordtxt,:passwordtxt_confirmation, :role])
    |> validate_format(:email, ~r/@/)
    |> update_change(:email, &String.downcase(&1))
    |> validate_length(:passwordtxt, min: 6, max: 100)
    |> validate_confirmation(:passwordtxt)
    |> unique_constraint(:email)
    |> hash_password
  end

  defp hash_password(changeset) do
    changeset
  end

end
