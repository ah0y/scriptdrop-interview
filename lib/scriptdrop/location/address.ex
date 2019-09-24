defmodule Scriptdrop.Location.Address do
  use Ecto.Schema
  import Ecto.Changeset

  schema "addresses" do
    field :city, :string
    field :state, :string
    field :street, :string
    field :zip, :integer

    #    belongs_to :patient, Scriptdrop.Customer.Patient, foreign_key: :patient_id
    #    belongs_to :courier, Scriptdrop.Company.Courier, foreign_key: :courier_id
    #    belongs_to :pharmacy, Scriptdrop.Company.Pharmacy, foreign_key: :pharmacy_id

    has_one :pharmacy, Scriptdrop.Company.Pharmacy
    has_one :courier, Scriptdrop.Company.Courier
    has_one :patient, Scriptdrop.Customer.Patient

    timestamps()
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:street, :city, :state, :zip])
    |> validate_required([:street, :city, :state, :zip])
  end
end
