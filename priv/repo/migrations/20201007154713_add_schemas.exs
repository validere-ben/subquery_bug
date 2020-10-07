defmodule SubqueryBug.Repo.Migrations.AddSchemas do
  use Ecto.Migration

  def up do
    create table(:users, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:email, :string, null: false)
      timestamps(type: :utc_datetime_usec)
    end

    create table(:posts, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:text, :text, null: false)
      add(:user_id, references(:users, on_delete: :nothing, type: :uuid), null: false)
      timestamps(type: :utc_datetime_usec)
    end
  end

  def down do
    drop(table(:posts))
    drop(table(:users))
  end
end
