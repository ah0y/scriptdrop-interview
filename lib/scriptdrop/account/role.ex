defmodule Scriptdrop.Account.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field :name, :string

    belongs_to :pharmacy, Scriptdrop.Company.Pharmacy, foreign_key: :pharmacy_id
    belongs_to :courier, Scriptdrop.Company.Courier, foreign_key: :courier_id

    many_to_many(
      :users,
      Scriptdrop.Coherence.User,
      join_through: Scriptdrop.Account.UserRole,
      join_keys: [
        role_id: :id,
        user_id: :id
      ],
      on_replace: :delete
    )
  end

  @doc false
  def changeset(courier, attrs) do
    courier
    |> cast(attrs, [:pharmacy_id, :courier_id])
    |> validate_required([:name, :address_id])
  end
end