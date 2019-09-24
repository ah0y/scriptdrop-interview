defmodule Scriptdrop.Customer.Patient do
  use Ecto.Schema
  import Ecto.Changeset

  schema "patients" do
    field :name, :string

#    has_one :address, Scriptdrop.Location.Address
    belongs_to :address, Scriptdrop.Location.Address, foreign_key: :address_id
    has_many :orders, Scriptdrop.Customer.Order

    timestamps()
  end

  @doc false
  def changeset(patient, attrs) do
    patient
    |> cast(attrs, [:name, :address_id])
    |> validate_required([:name, :address_id])
  end
end
