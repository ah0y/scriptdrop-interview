defmodule Scriptdrop.LocationTest do
  use Scriptdrop.DataCase

  alias Scriptdrop.Location

  describe "addresses" do
    alias Scriptdrop.Location.Address

    @valid_attrs %{city: "some city", state: "some state", street: "some street", zip: 42}
    @update_attrs %{city: "some updated city", state: "some updated state", street: "some updated street", zip: 43}
    @invalid_attrs %{city: nil, state: nil, street: nil, zip: nil}

    def address_fixture(attrs \\ %{}) do
      {:ok, address} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Location.create_address()

      address
    end

    test "list_addresses/0 returns all addresses" do
      address = address_fixture()
      assert Location.list_addresses() == [address]
    end

    test "get_address!/1 returns the address with given id" do
      address = address_fixture()
      assert Location.get_address!(address.id) == address
    end

    test "create_address/1 with valid data creates a address" do
      assert {:ok, %Address{} = address} = Location.create_address(@valid_attrs)
      assert address.city == "some city"
      assert address.state == "some state"
      assert address.street == "some street"
      assert address.zip == 42
    end

    test "create_address/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Location.create_address(@invalid_attrs)
    end

    test "update_address/2 with valid data updates the address" do
      address = address_fixture()
      assert {:ok, %Address{} = address} = Location.update_address(address, @update_attrs)
      assert address.city == "some updated city"
      assert address.state == "some updated state"
      assert address.street == "some updated street"
      assert address.zip == 43
    end

    test "update_address/2 with invalid data returns error changeset" do
      address = address_fixture()
      assert {:error, %Ecto.Changeset{}} = Location.update_address(address, @invalid_attrs)
      assert address == Location.get_address!(address.id)
    end

    test "delete_address/1 deletes the address" do
      address = address_fixture()
      assert {:ok, %Address{}} = Location.delete_address(address)
      assert_raise Ecto.NoResultsError, fn -> Location.get_address!(address.id) end
    end

    test "change_address/1 returns a address changeset" do
      address = address_fixture()
      assert %Ecto.Changeset{} = Location.change_address(address)
    end
  end
end
