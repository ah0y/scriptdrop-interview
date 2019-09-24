defmodule Scriptdrop.Company.Pharmacy do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pharmacies" do
    field :name, :string

    #    has_one :address, Scriptdrop.Location.Address
    belongs_to :address, Scriptdrop.Location.Address, foreign_key: :address_id
    belongs_to :courier, Scriptdrop.Company.Courier, foreign_key: :courier_id
    has_many :orders, Scriptdrop.Customer.Order

    timestamps()
  end

  @doc false
  def changeset(pharmacy, attrs) do
    pharmacy
    |> cast(attrs, [:name, :address_id, :courier_id])
    |> validate_required([:name, :address_id, :courier_id])
  end
end
