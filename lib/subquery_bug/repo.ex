defmodule SubqueryBug.Repo do
  use Ecto.Repo,
    otp_app: :subquery_bug,
    adapter: Ecto.Adapters.Postgres
end
