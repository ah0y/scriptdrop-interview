defmodule ScriptdropWeb.OrderController do
  use ScriptdropWeb, :controller

  alias Scriptdrop.Customer
  alias Scriptdrop.Customer.Order
#
#  plug :authorize_resource, model: Order
#  use ScriptdropWeb.ControllerAuthorization

  def index(conn, _params) do
    orders = Customer.list_orders()
    render(conn, "index.html", orders: orders)
  end

  def new(conn, _params) do
    changeset = Customer.change_order(%Order{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"order" => order_params}) do
    require IEx; IEx.pry()
    case Customer.create_order(order_params) do
      {:ok, order} ->
        conn
        |> put_flash(:info, "Order created successfully.")
        |> redirect(to: Routes.order_path(conn, :show, order))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    order = Customer.get_order!(id)
    render(conn, "show.html", order: order)
  end

  def edit(conn, %{"id" => id}) do
    order = Customer.get_order!(id)
    changeset = Customer.change_order(order)
    render(conn, "edit.html", order: order, changeset: changeset)
  end

  def update(conn, %{"id" => id, "order" => order_params}) do
    order = Customer.get_order!(id)

    case Customer.update_order(order, order_params) do
      {:ok, order} ->
        conn
        |> put_flash(:info, "Order updated successfully.")
        |> redirect(to: Routes.order_path(conn, :show, order))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", order: order, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    order = Customer.get_order!(id)
    {:ok, _order} = Customer.delete_order(order)

    conn
    |> put_flash(:info, "Order deleted successfully.")
    |> redirect(to: Routes.order_path(conn, :index))
  end
end
