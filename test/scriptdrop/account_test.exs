defmodule Scriptdrop.AccountTest do
  use Scriptdrop.DataCase

  alias Scriptdrop.Account

  describe "users" do
    alias Scriptdrop.Coherence.User

    @valid_attrs %{name: "abe", email: "email@example.com", password: "supersecretpassword", confirm_password: "supersecretpassword"}
    @invalid_attrs %{email: "bademail@bad", password: "short", confirm_password: "shot" }

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_user()
      user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Account.create_user(@valid_attrs)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_user(@invalid_attrs)
    end

    test "create_user/1 creates a user with a default role of pharmacist" do
      {:ok, user} = Account.create_user(@valid_attrs)
      assert user.roles == ["pharmacist"]
    end

    test "create_user/1 validates a correct role" do
      assert {:error, %Ecto.Changeset{}} = Account.create_user(Map.put(@valid_attrs, :roles, ["pilot", "courier"]))
    end

    test "create_courier/1 creates a user with the courier role set" do
      {:ok, user} = Account.create_courier(@valid_attrs)
      assert Enum.member?(user.roles, "courier")
      refute Enum.member?(user.roles, "pharmacist")
    end

    test "create_pharmacist/1 creates a user with the pharmacist role set" do
      {:ok, user} = Account.create_pharmacist(@valid_attrs)
      assert Enum.member?(user.roles, "pharmacist")
      refute Enum.member?(user.roles, "courier")
    end
  end
end