defmodule ScriptdropWeb.PharmacyController do
  use ScriptdropWeb, :controller

  alias Scriptdrop.Company
  alias Scriptdrop.Company.Pharmacy

  #  plug :authorize_resource, model: Pharmacy
  #  use ScriptdropWeb.ControllerAuthorization

  def index(conn, _params) do
    pharmacies = Company.list_pharmacies()
    render(conn, "index.html", pharmacies: pharmacies)
  end

  def new(conn, _params) do
    couriers = Company.load_couriers_datalist()
    changeset = Company.change_pharmacy(%Pharmacy{})
    render(conn, "new.html", changeset: changeset, couriers: couriers)
  end

  def create(conn, %{"pharmacy" => pharmacy_params}) do
    case Company.create_pharmacy(pharmacy_params) do
      {:ok, pharmacy} ->
        conn
        |> put_flash(:info, "Pharmacy created successfully.")
        |> redirect(to: Routes.pharmacy_path(conn, :show, pharmacy))

      {:error, %Ecto.Changeset{} = changeset} ->
        couriers = Company.load_couriers_datalist()
        render(conn, "new.html", changeset: changeset, couriers: couriers)
    end
  end

  def create(conn, %{"pharmacy" => pharmacy_params}) do
    case Company.create_pharmacy(pharmacy_params) do
      {:ok, pharmacy} ->
        conn
        |> put_flash(:info, "Pharmacy created successfully.")
        |> redirect(to: Routes.pharmacy_path(conn, :show, pharmacy))

      {:error, %Ecto.Changeset{} = changeset} ->
        couriers = Company.load_couriers_datalist()
        render(conn, "new.html", changeset: changeset, couriers: couriers)
    end
  end

  def show(conn, %{"id" => id}) do
    pharmacy = Company.get_pharmacy!(id)
    render(conn, "show.html", pharmacy: pharmacy)
  end

  def edit(conn, %{"id" => id}) do
    pharmacy = Company.get_pharmacy!(id)
    couriers = Company.load_couriers_datalist()
    changeset = Company.change_pharmacy(pharmacy)
    render(conn, "edit.html", pharmacy: pharmacy, changeset: changeset, couriers: couriers)
  end

  def update(conn, %{"id" => id, "pharmacy" => pharmacy_params}) do
    pharmacy = Company.get_pharmacy!(id)
    case Company.update_pharmacy(pharmacy, pharmacy_params) do
      {:ok, pharmacy} ->
        conn
        |> put_flash(:info, "Pharmacy updated successfully.")
        |> redirect(to: Routes.pharmacy_path(conn, :show, pharmacy))
      {:error, %Ecto.Changeset{} = changeset} ->
        couriers = Company.load_couriers_datalist()
        render(conn, "edit.html", pharmacy: pharmacy, changeset: changeset, couriers: couriers)
    end
  end

  def delete(conn, %{"id" => id}) do
    pharmacy = Company.get_pharmacy!(id)
    {:ok, _pharmacy} = Company.delete_pharmacy(pharmacy)

    conn
    |> put_flash(:info, "Pharmacy deleted successfully.")
    |> redirect(to: Routes.pharmacy_path(conn, :index))
  end
end
