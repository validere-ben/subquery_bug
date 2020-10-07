import Config

config :subquery_bug,
  ecto_repos: [SubqueryBug.Repo],
  generators: [binary_id: true]

config :subquery_bug, SubqueryBug.Repo,
  username: "postgres",
  password: "postgres",
  database: "subquery_bug_dev",
  hostname: "localhost",
  port: 5432
