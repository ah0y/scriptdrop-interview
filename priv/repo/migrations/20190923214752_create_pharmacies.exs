defmodule Scriptdrop.Repo.Migrations.CreatePharmacies do
  use Ecto.Migration

  def change do
    create table(:pharmacies) do
      add :name, :string

      add :address_id, references(:addresses, on_delete: :nothing)
      timestamps()
    end
    create index(:pharmacies, [:address_id])
  end
end
