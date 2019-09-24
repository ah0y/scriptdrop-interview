defmodule Scriptdrop.Repo do
  use Ecto.Repo,
    otp_app: :scriptdrop,
    adapter: Ecto.Adapters.Postgres
end
