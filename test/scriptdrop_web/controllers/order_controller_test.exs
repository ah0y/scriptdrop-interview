defmodule ScriptdropWeb.OrderControllerTest do
  use ScriptdropWeb.ConnCase

  alias Scriptdrop.Customer
  import Scriptdrop.Factory

  @patient  %{
    patient: %{
      address: %{
        city: "a",
        state: "a",
        street: "1",
        zip: 1
      },
      name: "a"
    }
  }
  @create_attrs %{pickup_date: ~N[2010-04-17 14:00:00], undelieverable: true, delivered: true}
  @update_attrs %{pickup_date: ~N[2011-05-18 15:01:01], undelieverable: false, delivered: false}
  @invalid_attrs %{pickup_date: nil, undelieverable: nil, delivered: nil}


  def fixture(:order, pharmacy_id) do
    {:ok, order} =
      %{}
      |> Enum.into(@create_attrs)
      |> Enum.into(@patient)
      |> Map.merge(%{pharmacy_id: pharmacy_id})
      |> Customer.create_order()
    order
  end

  describe "index" do
    setup [:create_pharmacist_session]

    test "lists all orders", %{conn: conn} do
      conn = get(conn, Routes.order_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Orders"
    end
  end

  describe "new order" do
    setup [:create_pharmacist_session]

    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.order_path(conn, :new))
      assert html_response(conn, 200) =~ "New Order"
    end
  end

  describe "create order" do
    setup [:create_pharmacist_session]

    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.order_path(conn, :create), order: Enum.into(@create_attrs, @patient))
      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.order_path(conn, :show, id)

      saved_assigns = conn.assigns
      conn =
        conn
        |> recycle()
        |> Map.put(:assigns, saved_assigns)

      conn = get(conn, Routes.order_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Order"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.order_path(conn, :create), order: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Order"
    end
  end

  describe "edit order" do
    setup [:create_order]

    test "renders form for editing chosen order", %{conn: conn, order: order} do
      conn = get(conn, Routes.order_path(conn, :edit, order))
      assert html_response(conn, 200) =~ "Edit Order"
    end
  end

  describe "update order" do
    setup [:create_order]

    test "redirects when data is valid", %{conn: conn, order: order} do
      conn = put(conn, Routes.order_path(conn, :update, order), order: @update_attrs)

      assert redirected_to(conn) == Routes.order_path(conn, :show, order)

      saved_assigns = conn.assigns
      conn =
        conn
        |> recycle()
        |> Map.put(:assigns, saved_assigns)

      conn = get(conn, Routes.order_path(conn, :show, order))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, order: order} do
      #passing?
      conn = put(conn, Routes.order_path(conn, :update, order), order: @invalid_attrs)
      assert html_response(conn, 200)
    end
  end

  describe "delete order" do
    setup [:create_order]

    test "deletes chosen order", %{conn: conn, order: order} do
      conn = delete(conn, Routes.order_path(conn, :delete, order))
      #can't delete orders!
      assert redirected_to(conn) == "/"
    end
  end

  defp create_order(_) do
    pharmacy = insert(:pharmacy)
    user = Scriptdrop.Coherence.User.changeset(
             %Scriptdrop.Coherence.User{},
             %{
               name: "test",
               email: "test@example.com",
               password: "test",
               password_confirmation: "test",
               roles: "pharmacist",
               pharmacy_id: pharmacy.id
             }
           )
           |> Scriptdrop.Repo.insert!
    order = fixture(:order, user.pharmacy_id)
    {:ok, conn: assign(build_conn(), :current_user, user), user: user, order: order}
  end

  defp create_pharmacist_session(_)  do
    pharmacy = insert(:pharmacy)
    user = Scriptdrop.Coherence.User.changeset(
             %Scriptdrop.Coherence.User{},
             %{
               name: "test",
               email: "test@example.com",
               password: "test",
               password_confirmation: "test",
               roles: "pharmacist",
               pharmacy_id: pharmacy.id
             }
           )
           |> Scriptdrop.Repo.insert!
    {:ok, conn: assign(build_conn(), :current_user, user), user: user}
  end
end
