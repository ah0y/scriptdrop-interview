defmodule Scriptdrop.CustomerTest do
  use Scriptdrop.DataCase

  alias Scriptdrop.Customer

  describe "patients" do
    alias Scriptdrop.Customer.Patient

    @address %{
      address: %{
        street: "some street",
        city: "some city",
        state: "some state",
        zip: 1234
      }
    }
    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def patient_fixture(attrs \\ %{}) do
      {:ok, patient} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Enum.into(@address)
        |> Customer.create_patient()

      patient
    end

    test "list_patients/0 returns all patients" do
      patient = patient_fixture()
      assert Customer.list_patients() == [patient]
    end

    test "get_patient!/1 returns the patient with given id" do
      patient = patient_fixture()
      assert Customer.get_patient!(patient.id) == patient
    end

    test "create_patient/1 with valid data creates a patient" do
      assert {:ok, %Patient{} = patient} = Customer.create_patient(Map.merge(@address, @valid_attrs))
      assert patient.name == "some name"
    end

    test "create_patient/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Customer.create_patient(@invalid_attrs)
    end

    test "update_patient/2 with valid data updates the patient" do
      patient = patient_fixture()
      assert {:ok, %Patient{} = patient} = Customer.update_patient(patient, @update_attrs)
      assert patient.name == "some updated name"
    end

    test "update_patient/2 with invalid data returns error changeset" do
      patient = patient_fixture()
      assert {:error, %Ecto.Changeset{}} = Customer.update_patient(patient, @invalid_attrs)
      assert patient == Customer.get_patient!(patient.id)
    end

    test "delete_patient/1 deletes the patient" do
      patient = patient_fixture()
      assert {:ok, %Patient{}} = Customer.delete_patient(patient)
      assert_raise Ecto.NoResultsError, fn -> Customer.get_patient!(patient.id) end
    end

    test "change_patient/1 returns a patient changeset" do
      patient = patient_fixture()
      assert %Ecto.Changeset{} = Customer.change_patient(patient)
    end
  end

  describe "orders" do
    alias Scriptdrop.Customer.Order

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
    @valid_attrs %{pickup_date: ~N[2010-04-17 14:00:00], undelieverable: true, delivered: true}
    @update_attrs %{pickup_date: ~N[2011-05-18 15:01:01], undelieverable: false, delivered: false}
    @invalid_attrs %{pickup_date: nil, undelieverable: nil, delivered: nil}

    def order_fixture(attrs \\ %{}) do
      {:ok, order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Enum.into(@patient)
        |> Customer.create_order()
      order
    end

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Customer.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Customer.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      assert {:ok, %Order{} = order} = Customer.create_order(Map.merge(@patient, @valid_attrs))
      assert order.pickup_date == ~N[2010-04-17 14:00:00]
      assert order.undelieverable == true
      assert order.delivered == true
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Customer.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      assert {:ok, %Order{} = order} = Customer.update_order(order, @update_attrs)
      assert order.pickup_date == ~N[2011-05-18 15:01:01]
      assert order.delivered == false
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Customer.update_order(order, @invalid_attrs)
      assert order == Customer.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Customer.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Customer.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Customer.change_order(order)
    end
  end
end
