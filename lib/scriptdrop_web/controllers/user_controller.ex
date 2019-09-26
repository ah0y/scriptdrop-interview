defmodule ScriptdropWeb.UserController do
  use ScriptdropWeb, :controller

  import Ecto.Query
  alias Scriptdrop.Account
  alias Scriptdrop.Coherence.User
  alias Scriptdrop.Company
  #  plug :authorize_resource, model: Scriptdrop.Coherence.User
  #  use ScriptdropWeb.ControllerAuthorization

  def index(conn, _params) do
    users = Account.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Account.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Account.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: Routes.page_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Account.get_user!(id)
    render(
      conn,
      "show.html",
      user: user
    )
  end

  def edit(conn, %{"id" => id}) do
    user = Account.get_user!(id)
    pharmacies = Company.load_pharmacies()
    couriers = Company.load_couriers()
    changeset = Account.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset, pharmacies: pharmacies, couriers: couriers)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Account.get_user!(id)
    case Account.update_user(user, user_params) do
      {:ok, user} ->
        conn = conn
               |> Plug.Conn.put_session(:current_user, user)
               |> put_flash(:info, "User updated successfully.")
        redirect(conn, to: Routes.user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        pharmacies = Company.load_pharmacies()
        couriers = Company.load_couriers()
        render(conn, "edit.html", user: user, changeset: changeset, pharmacies: pharmacies, couriers: couriers)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Account.get_user!(id)
    {:ok, _user} = Account.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.user_path(conn, :index))
  end
end
