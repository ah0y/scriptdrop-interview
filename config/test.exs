use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.

if System.get_env("DATABASE_URL") do
  config :scriptdrop, Scriptdrop.Repo,
         adapter: Ecto.Adapters.Postgres,
         url: System.get_env("DATABASE_URL"),
         pool: Ecto.Adapters.SQL.Sandbox
else
  # ... Your Local DB Config Here
  # Configure your database
  config :scriptdrop, Scriptdrop.Repo,
         username: "postgres",
         password: "postgres",
         database: "scriptdrop_test",
         hostname: "localhost",
         pool: Ecto.Adapters.SQL.Sandbox
end
config :scriptdrop, ScriptdropWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

