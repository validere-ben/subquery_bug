defmodule SubqueryBug do
  alias SubqueryBug.Repo
  alias SubqueryBug.User
  alias SubqueryBug.Post

  import Ecto.Query

  def setup_data do
    Repo.transaction(fn ->
      user = Repo.insert!(User.changeset(%User{}, %{email: "foo@example.com"}))
      post = Repo.insert!(Post.changeset(%Post{}, %{text: "Hello World", user_id: user.id}))
      {user, post}
    end)
  end

  @doc """
  A `NaiveDateTime` is returned instead of a `DateTime` despite timestamp type being set as a
  `utc_datetime_usec` type in both schemas + migrations.

  Only when using a `subquery` - `u in User, ...` returns a `DateTime` as expected
  """
  def timestamp_type do
    base_query = User

    Repo.one(
      from(u in subquery(base_query),
        select: u.updated_at
      )
    )
  end

  @doc """
  A `DBConnection.EncodeError` is now raised as of 3.5.0 when comparing a binary_id field from
  the source schema in a subquery to a `t:String.t/0`

  It must be explicitly dumped now when using a subquery
  ```elixir
  {:ok, dumped_id} = Ecto.UUID.dump(uuid)

  Repo.all(
    from(
      p in subquery(base_query),
      where: p.user_id == ^dumped_id
    )
  )
  ```
  """
  def uuid_cast do
    uuid = Ecto.UUID.generate()

    base_query = Post

    Repo.all(
      from(
        p in subquery(base_query),
        where: p.user_id == ^uuid
      )
    )
  end
end
