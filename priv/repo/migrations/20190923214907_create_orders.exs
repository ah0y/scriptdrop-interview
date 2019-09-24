defmodule Scriptdrop.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :undelieverable, :boolean, default: false, null: false
      add :delivered, :boolean, default: false, null: false
      add :pickup_date, :naive_datetime

      add :patient_id, references(:patients, on_delete: :nothing)
      add :pharmacy_id, references(:pharmacies, on_delete: :nothing)
      timestamps()
    end
    create index(:orders, [:patient_id])
    create index(:orders, [:pharmacy_id])
  end
end
