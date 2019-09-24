defmodule Scriptdrop.Repo.Migrations.AddRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :name, :string

      add :courier_id, references(:couriers, on_delete: :nothing)
      add :pharmacy_id, references(:pharmacies, on_delete: :nothing)
    end
    create index(:roles, [:courier_id])
    create index(:roles, [:pharmacy_id])
  end
end
