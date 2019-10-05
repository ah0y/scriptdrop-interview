defmodule ScriptdropWeb.PharmacyControllerTest do
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

  def fixture(:pharmacy) do
    courier = fixture(:courier)
    {:ok, pharmacy} =
      %{}
      |> Enum.into(@create_attrs)
      |> Enum.into(@address)
      |> Enum.into(%{courier_id: courier.id})
      |> Company.create_pharmacy()
    pharmacy
  end

  describe "index" do
    setup [:create_pharmacist_session]

    test "lists all pharmacies", %{conn: conn} do
      conn = get(conn, Routes.pharmacy_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Pharmacies"
    end
  end

  describe "new pharmacy" do
    setup [:create_user_session]

    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.pharmacy_path(conn, :new))
      assert html_response(conn, 200) =~ "New Pharmacy"
    end
  end

  describe "create pharmacy" do
    setup [:create_user_session]

    test "redirects to show when data is valid", %{conn: conn} do

      conn = post(conn, Routes.pharmacy_path(conn, :create), pharmacy: Enum.into(@address, @create_attrs))

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.pharmacy_path(conn, :show, id)

      saved_assigns = conn.assigns
      conn =
        conn
        |> recycle()
        |> Map.put(:assigns, saved_assigns)

      conn = get(conn, Routes.pharmacy_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Pharmacy"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.pharmacy_path(conn, :create), pharmacy: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Pharmacy"
    end
  end

  describe "edit pharmacy" do
    setup [:create_pharmacy]

    test "renders form for editing chosen pharmacy", %{conn: conn, pharmacy: pharmacy} do
      conn = get(conn, Routes.pharmacy_path(conn, :edit, pharmacy))
      assert html_response(conn, 200) =~ "Edit Pharmacy"
    end
  end

  describe "update pharmacy" do
    setup [:create_pharmacy]

    test "redirects when data is valid", %{conn: conn, pharmacy: pharmacy} do
      conn = put(conn, Routes.pharmacy_path(conn, :update, pharmacy), pharmacy: @update_attrs)
      assert redirected_to(conn) == Routes.pharmacy_path(conn, :show, pharmacy)

      saved_assigns = conn.assigns
      conn =
        conn
        |> recycle()
        |> Map.put(:assigns, saved_assigns)

      conn = get(conn, Routes.pharmacy_path(conn, :show, pharmacy))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, pharmacy: pharmacy} do
      conn = put(conn, Routes.pharmacy_path(conn, :update, pharmacy), pharmacy: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Pharmacy"
    end
  end

  describe "delete pharmacy" do
    setup [:create_pharmacy]
#
#    test "deletes chosen pharmacy", %{conn: conn, pharmacy: pharmacy} do
#      conn = delete(conn, Routes.pharmacy_path(conn, :delete, pharmacy))
#      #can't delete pharmacies!
#      assert redirected_to(conn) == "/"
#    end
  end

  defp create_pharmacy(_) do
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
    {:ok, conn: assign(build_conn(), :current_user, user), user: user, pharmacy: pharmacy}
  end

  defp create_user_session(_)  do
#    pharmacy = insert(:pharmacy)
    user = Scriptdrop.Coherence.User.changeset(
             %Scriptdrop.Coherence.User{},
             %{
               name: "test",
               email: "test@example.com",
               password: "test",
               password_confirmation: "test",
               roles: "pharmacist",
             }
           )
           |> Scriptdrop.Repo.insert!
    {:ok, conn: assign(build_conn(), :current_user, user), user: user}
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
