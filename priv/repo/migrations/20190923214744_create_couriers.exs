defmodule Scriptdrop.Repo.Migrations.CreateCouriers do
  use Ecto.Migration

  def change do
    create table(:couriers) do
      add :name, :string
      add :address_id, references(:addresses, on_delete: :nothing)
      timestamps()
    end
    create index(:couriers, [:address_id])
  end
end
