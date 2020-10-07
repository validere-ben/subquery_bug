defmodule SubqueryBug.User do
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @fields [:email]

  schema "users" do
    field(:email, :string)
    has_many(:posts, SubqueryBug.Post)
    timestamps(type: :utc_datetime_usec)
  end

  def changeset(struct, params \\ %{}) do
    cast(struct, params, @fields)
  end
end
