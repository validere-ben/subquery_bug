defmodule SubqueryBug.Post do
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @fields [:text, :user_id]

  schema "posts" do
    field(:text, :string)
    belongs_to(:user, SubqueryBug.User)
    timestamps(type: :utc_datetime_usec)
  end

  def changeset(struct, params \\ %{}) do
    cast(struct, params, @fields)
  end
end
