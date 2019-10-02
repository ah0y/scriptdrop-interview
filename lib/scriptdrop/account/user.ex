defmodule Scriptdrop.Coherence.User do
  @moduledoc false
  use Ecto.Schema
  use Coherence.Schema

  import Ecto.Changeset

  schema "users" do
    field(:name, :string)
    field(:email, :string)
    field(:roles, :string)

    belongs_to :pharmacy, Scriptdrop.Company.Pharmacy, foreign_key: :pharmacy_id
    belongs_to :courier, Scriptdrop.Company.Courier, foreign_key: :courier_id

    coherence_schema()

    timestamps()
  end

    @doc false
  @spec changeset(Ecto.Schema.t(), Map.t()) :: Ecto.Changeset.t()
  def changeset(model, %{"roles" => roles, "pharmacy_id" => pharmacy_id} = params) when roles == "pharmacist" and pharmacy_id != ""  do
    model
    |> cast(params, [:pharmacy_id, :courier_id, :roles, :name, :email] ++ coherence_fields())
    |> Ecto.Changeset.validate_inclusion(:roles, ["pharmacist", "courier"])
    |> foreign_key_constraint(:pharmacy_id)
    |> put_change(:courier_id, nil)
    |> validate_required([:roles, :name, :email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> validate_coherence(params)
  end

  @doc false
  @spec changeset(Ecto.Schema.t(), Map.t()) :: Ecto.Changeset.t()
  def changeset(model, %{"roles" => roles, "courier_id" => courier_id} = params) when roles == "courier" and courier_id != "" do
    model
    |> cast(params, [:pharmacy_id, :courier_id, :roles, :name, :email] ++ coherence_fields())
    |> Ecto.Changeset.validate_inclusion(:roles, ["pharmacist", "courier"])
    |> foreign_key_constraint(:courier_id)
    |> put_change(:pharmacy_id, nil)
    |> validate_required([:roles, :name, :email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> validate_coherence(params)
  end

  @doc false
  @spec changeset(Ecto.Schema.t(), Map.t()) :: Ecto.Changeset.t()
  def changeset(model, params \\ %{})  do
    model
    |> cast(params, [:pharmacy_id, :courier_id, :roles, :name, :email] ++ coherence_fields())
    |> Ecto.Changeset.validate_inclusion(:roles, ["pharmacist", "courier"])
    |> validate_required([:roles, :name, :email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> validate_coherence(params)
  end

  @doc false
  @spec changeset(Ecto.Schema.t(), Map.t()) :: Ecto.Changeset.t()

  @doc false
  @spec changeset(Ecto.Schema.t(), Map.t(), atom) :: Ecto.Changeset.t()
  def changeset(model, params, :password) do
    model
    |> cast(
         params,
         ~w(password password_confirmation reset_password_token reset_password_sent_at)a
       )
    |> validate_coherence_password_reset(params)
  end

  def changeset(model, params, :registration) do
    changeset = changeset(model, params)

    if Config.get(:confirm_email_updates) && Map.get(params, "email", false) && model.id do
      changeset
      |> put_change(:unconfirmed_email, get_change(changeset, :email))
      |> delete_change(:email)
    else
      changeset
    end
  end
end
