defmodule ScriptdropWeb.OrderController do
  use ScriptdropWeb, :controller

  alias Scriptdrop.Customer
  alias Scriptdrop.Customer.Order
  #
  #  plug :authorize_resource, model: Order
  #  use ScriptdropWeb.ControllerAuthorization

  def index(
        %Plug.Conn{
          private: %{
            plug_session: %{
              "current_user" => %Scriptdrop.Coherence.User{
                "pharmacy_id": pharmacy_id
              }
            }
          }
        } = conn,

        _params
      ) when is_integer(pharmacy_id) do

    orders = Customer.list_pharmacy_orders(pharmacy_id)
    render(conn, "index.html", orders: orders)
  end

  def index(
        %Plug.Conn{
          private: %{
            plug_session: %{
              "current_user" => %Scriptdrop.Coherence.User{
                "courier_id": courier_id
              }
            }
          }
        } = conn,
        _params
      ) when is_integer(courier_id) do
    orders = Customer.list_courier_orders(courier_id)
    render(conn, "index.html", orders: orders)
  end

  def index(
        conn = %Plug.Conn{
          assigns: %{
            current_user: %{
              pharmacy_id: pharmacy_id
            }
          }
        },
        _params
      ) when is_integer(pharmacy_id) do
    orders = Customer.list_pharmacy_orders(pharmacy_id)
    render(conn, "index.html", orders: orders)
  end

  def index(
        conn = %Plug.Conn{
          assigns: %{
            current_user: %{
              courier_id: courier_id
            }
          }
        },
        _params
      ) when is_integer(courier_id) do
    orders = Customer.list_courier_orders(courier_id)
    render(conn, "index.html", orders: orders)
  end

  def new(conn, _params) do
    changeset = Customer.change_order(%Order{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(
        %Plug.Conn{
          private: %{
            plug_session: %{
              "current_user" => %Scriptdrop.Coherence.User{
                "pharmacy_id": pharmacy_id
              }
            }
          }
        } = conn,
        %{"order" => order_params}
      ) do
    case Customer.create_order(Map.merge(%{"pharmacy_id" => pharmacy_id}, order_params)) do
      {:ok, order} ->
        conn
        |> put_flash(:info, "Order created successfully.")
        |> redirect(to: Routes.order_path(conn, :show, order))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def create(
        conn = %Plug.Conn{
          assigns: %{
            current_user: %{
              pharmacy_id: pharmacy_id
            }
          }
        },
        %{"order" => order_params}
      ) do
    case Customer.create_order(Map.merge(%{"pharmacy_id" => pharmacy_id}, order_params)) do
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
            |> Scriptdrop.Repo.preload([{:patient, :address}])
    changeset = Customer.change_order(order)
    render(conn, "edit.html", order: order, changeset: changeset)
  end

  def update(conn, %{"id" => id, "order" => order_params}) do
    order = Customer.get_order!(id)
            |> Scriptdrop.Repo.preload([{:patient, :address}])
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
