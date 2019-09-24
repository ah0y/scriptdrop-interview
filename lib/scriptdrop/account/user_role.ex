defmodule Scriptdrop.Account.UserRole do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias Scriptdrop.Coherence.User
  alias Scriptdrop.Account.Role

  @already_exists "ALREADY_EXISTS"
  @primary_key false
  schema "user_roles" do
    belongs_to :users, User, foreign_key: :user_id
    belongs_to :roles, Role, foreign_key: :role_id

    timestamps()
  end

  @doc false
  @required_fields [:user_id, :role_id]
  def changeset(user_role, attrs) do
    user_role
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:role_id)
    |> foreign_key_constraint(:user_id)
    |> unique_constraint(
         [:user, :role],
         name: :user_id_role_id_unique_index,
         message: @already_exists
       )
  end
end
