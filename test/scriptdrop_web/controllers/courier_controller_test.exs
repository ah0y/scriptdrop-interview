defmodule ScriptdropWeb.CourierControllerTest do
  use ScriptdropWeb.ConnCase

  alias Scriptdrop.Company
  import Scriptdrop.Factory

  @address %{address: %{street: "some street", city: "some city", state: "some state", zip: 1234}}
  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:courier) do
    {:ok, courier} = Company.create_courier(Map.merge(@address, @create_attrs))
    courier
  end

  describe "index" do
    setup [:create_courier_session]

    test "lists all couriers", %{conn: conn} do
      conn = get(conn, Routes.courier_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Couriers"
    end
  end

  describe "new courier" do
    setup [:create_user_session]

    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.courier_path(conn, :new))
      assert html_response(conn, 200) =~ "New Courier"
    end
  end

  describe "create courier" do
    setup [:create_user_session]

    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.courier_path(conn, :create), courier: Enum.into(@address, @create_attrs))

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.courier_path(conn, :show, id)

      saved_assigns = conn.assigns
      conn =
        conn
        |> recycle()
        |> Map.put(:assigns, saved_assigns)

      conn = get(conn, Routes.courier_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Courier"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.courier_path(conn, :create), courier: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Courier"
    end
  end

  describe "edit courier" do
    setup [:create_courier]

    test "renders form for editing chosen courier", %{conn: conn, courier: courier} do
      conn = get(conn, Routes.courier_path(conn, :edit, courier))
      assert html_response(conn, 200) =~ "Edit Courier"
    end
  end

  describe "update courier" do
    setup [:create_courier]

    test "redirects when data is valid", %{conn: conn, courier: courier} do
      conn = put(conn, Routes.courier_path(conn, :update, courier), courier: @update_attrs)
      assert redirected_to(conn) == Routes.courier_path(conn, :show, courier)

      saved_assigns = conn.assigns
      conn =
        conn
        |> recycle()
        |> Map.put(:assigns, saved_assigns)

      conn = get(conn, Routes.courier_path(conn, :show, courier))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, courier: courier} do
      conn = put(conn, Routes.courier_path(conn, :update, courier), courier: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Courier"
    end
  end

  describe "delete courier" do
    setup [:create_courier]

#    test "deletes chosen courier", %{conn: conn, courier: courier} do
#      conn = delete(conn, Routes.courier_path(conn, :delete, courier))
#      #can't delete couriers!
#      assert redirected_to(conn) == "/"
#    end
  end

  defp create_courier(_) do
    courier = insert(:courier)
    user = Scriptdrop.Coherence.User.changeset(
             %Scriptdrop.Coherence.User{},
             %{
               name: "test",
               email: "test@example.com",
               password: "test",
               password_confirmation: "test",
               roles: "courier",
               courier_id: courier.id
             }
           )
           |> Scriptdrop.Repo.insert!
    {:ok, conn: assign(build_conn(), :current_user, user), user: user, courier: courier}
  end

  defp create_user_session(_)  do
    user = Scriptdrop.Coherence.User.changeset(
             %Scriptdrop.Coherence.User{},
             %{
               name: "test",
               email: "test@example.com",
               password: "test",
               password_confirmation: "test",
               roles: "courier",
             }
           )
           |> Scriptdrop.Repo.insert!
    {:ok, conn: assign(build_conn(), :current_user, user), user: user}
  end

  defp create_courier_session(_)  do
    courier = insert(:courier)
    user = Scriptdrop.Coherence.User.changeset(
             %Scriptdrop.Coherence.User{},
             %{
               name: "test",
               email: "test@example.com",
               password: "test",
               password_confirmation: "test",
               roles: "courier",
               courier_id: courier.id
             }
           )
           |> Scriptdrop.Repo.insert!
    {:ok, conn: assign(build_conn(), :current_user, user), user: user}
  end
end
