defmodule Scriptdrop.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :street, :string
      add :city, :string
      add :state, :string
      add :zip, :integer

      timestamps()
    end

  end
end
