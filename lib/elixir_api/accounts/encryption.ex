defmodule ElixirApi.Accounts.Encryption do
  alias Comeonin.Bcrypt

  def hash_password(password), do: Bcrypt.add_hash(password)
  def dummy_check_password(), do: Bcrypt.dummy_checkpw()
  def validate_password(password, hash), do: Bcrypt.checkpw(password, hash)

end
