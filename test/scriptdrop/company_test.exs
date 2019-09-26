defmodule Scriptdrop.CompanyTest do
  use Scriptdrop.DataCase

  alias Scriptdrop.Company

  describe "couriers" do
    alias Scriptdrop.Company.Courier

    @address %{address: %{street: "some street", city: "some city", state: "some state", zip: 1234}}
    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def courier_fixture(attrs \\ %{}) do
      {:ok, courier} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Enum.into(@address)
        |> Company.create_courier()

      courier
    end

    test "list_couriers/0 returns all couriers" do
      courier = courier_fixture()
      assert Company.list_couriers() == [courier]
    end

    test "get_courier!/1 returns the courier with given id" do
      courier = courier_fixture()
      assert Company.get_courier!(courier.id) == courier
    end

    test "create_courier/1 with valid data creates a courier" do
      assert {:ok, %Courier{} = courier} = Company.create_courier(Map.merge(@address, @valid_attrs))
      assert courier.name == "some name"
    end

    test "create_courier/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Company.create_courier(@invalid_attrs)
    end

    test "update_courier/2 with valid data updates the courier" do
      courier = courier_fixture()
      assert {:ok, %Courier{} = courier} = Company.update_courier(courier, @update_attrs)
      assert courier.name == "some updated name"
    end

    test "update_courier/2 with invalid data returns error changeset" do
      courier = courier_fixture()
      assert {:error, %Ecto.Changeset{}} = Company.update_courier(courier, @invalid_attrs)
      assert courier == Company.get_courier!(courier.id)
    end

    test "delete_courier/1 deletes the courier" do
      courier = courier_fixture()
      assert {:ok, %Courier{}} = Company.delete_courier(courier)
      assert_raise Ecto.NoResultsError, fn -> Company.get_courier!(courier.id) end
    end

    test "change_courier/1 returns a courier changeset" do
      courier = courier_fixture()
      assert %Ecto.Changeset{} = Company.change_courier(courier)
    end
  end

  describe "pharmacies" do
    alias Scriptdrop.Company.Pharmacy

    @address %{address: %{street: "some street", city: "some city", state: "some state", zip: 1234}}
    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def pharmacy_fixture(attrs \\ %{}) do
      courier = courier_fixture()
      {:ok, pharmacy} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Enum.into(@address)
        |> Enum.into(%{courier_id: courier.id})
        |> Company.create_pharmacy()
      pharmacy
    end

    test "list_pharmacies/0 returns all pharmacies" do
      pharmacy = pharmacy_fixture()
      assert Company.list_pharmacies() == [pharmacy]
    end

    test "get_pharmacy!/1 returns the pharmacy with given id" do
      pharmacy = pharmacy_fixture()
      assert Company.get_pharmacy!(pharmacy.id) == pharmacy
    end

    test "create_pharmacy/1 with valid data creates a pharmacy" do
      assert {:ok, %Pharmacy{} = pharmacy} = Company.create_pharmacy(Map.merge(@address, @valid_attrs))
      assert pharmacy.name == "some name"
    end

    test "create_pharmacy/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Company.create_pharmacy(@invalid_attrs)
    end

    test "update_pharmacy/2 with valid data updates the pharmacy" do
      pharmacy = pharmacy_fixture()
      assert {:ok, %Pharmacy{} = pharmacy} = Company.update_pharmacy(pharmacy, @update_attrs)
      assert pharmacy.name == "some updated name"
    end

    test "update_pharmacy/2 with invalid data returns error changeset" do
      pharmacy = pharmacy_fixture()
      assert {:error, %Ecto.Changeset{}} = Company.update_pharmacy(pharmacy, @invalid_attrs)
      assert pharmacy == Company.get_pharmacy!(pharmacy.id)
    end

    test "delete_pharmacy/1 deletes the pharmacy" do
      pharmacy = pharmacy_fixture()
      assert {:ok, %Pharmacy{}} = Company.delete_pharmacy(pharmacy)
      assert_raise Ecto.NoResultsError, fn -> Company.get_pharmacy!(pharmacy.id) end
    end

    test "change_pharmacy/1 returns a pharmacy changeset" do
      pharmacy = pharmacy_fixture()
      assert %Ecto.Changeset{} = Company.change_pharmacy(pharmacy)
    end
  end
end
