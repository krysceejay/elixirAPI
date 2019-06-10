defmodule ElixirApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias ElixirApi.Accounts.Encryption

  schema "users" do
    field :email, :string, unique: true
    field :first_name, :string
    field :last_name, :string
    field :password, :string
    field :role, :string, default: "user"

    ##Virtual Fields ##
    field :passwordfield, :string, virtual: true
    field :passwordfield_confirmation, :string, virtual: true

    timestamps()
  end

  # @required_fields ~w(email name password_field)
  @optional_fields ~w()

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :passwordfield, :role], @optional_fields)
    |> validate_required([:first_name, :last_name, :email, :passwordfield, :role])
    |> validate_format(:email, ~r/@/)
    |> update_change(:email, &String.downcase(&1))
    |> validate_length(:passwordfield, min: 6, max: 100)
    |> validate_confirmation(:passwordfield)
    |> unique_constraint(:email)
    |> encrypt_password
  end

  defp encrypt_password(changeset) do
    password = get_change(changeset, :passwordfield)

    if password do
      encrypted_password = Encryption.hash_password(password).password_hash

      put_change(changeset, :password, encrypted_password)

    else
      changeset
    end

  end

end
