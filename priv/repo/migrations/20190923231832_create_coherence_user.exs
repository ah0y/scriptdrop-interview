defmodule Scriptdrop.Repo.Migrations.CreateCoherenceUser do
  use Ecto.Migration
  def change do
    create table(:users) do

      add :roles, :string
      add :courier_id, references(:couriers, on_delete: :nothing)
      add :pharmacy_id, references(:pharmacies, on_delete: :nothing)

      add :name, :string
      add :email, :string
      # authenticatable
      add :password_hash, :string
      # recoverable
      add :reset_password_token, :string
      add :reset_password_sent_at, :utc_datetime
      # lockable
      add :failed_attempts, :integer, default: 0
      add :locked_at, :utc_datetime
      # trackable
      add :sign_in_count, :integer, default: 0
      add :current_sign_in_at, :utc_datetime
      add :last_sign_in_at, :utc_datetime
      add :current_sign_in_ip, :string
      add :last_sign_in_ip, :string
      # unlockable_with_token
      add :unlock_token, :string
      
      timestamps()
    end
    create unique_index(:users, [:email])
    create index(:users, [:courier_id])
    create index(:users, [:pharmacy_id])
  end
end
