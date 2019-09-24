defmodule Scriptdrop.Repo.Migrations.AddUserRoles do
  use Ecto.Migration

  def change do
    create table(:user_roles, primary_key: false) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :role_id, references(:roles, on_delete: :delete_all)
      timestamps()
    end

    create(index(:user_roles, [:user_id]))
    create(index(:user_roles, [:role_id]))

    create(unique_index(:user_roles, [:user_id, :role_id], name: :user_id_role_id_unique_index))
  end
end
