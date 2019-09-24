defmodule Scriptdrop.Repo.Migrations.CreatePatients do
  use Ecto.Migration

  def change do
    create table(:patients) do
      add :name, :string

      add :address_id, references(:addresses, on_delete: :nothing)
      timestamps()
    end
    create index(:patients, [:address_id])
  end
end
