defmodule Scriptdrop.Repo.Migrations.CreatePharmacies do
  use Ecto.Migration

  def change do
    create table(:pharmacies) do
      add :name, :string

      add :address_id, references(:addresses, on_delete: :nothing)
      add :courier_id, references(:couriers, on_delete: :nothing)
      timestamps()
    end
    create index(:pharmacies, [:address_id])
    create index(:pharmacies, [:courier_id])
  end
end
