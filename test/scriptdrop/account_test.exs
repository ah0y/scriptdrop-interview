defmodule Scriptdrop.AccountTest do
  use Scriptdrop.DataCase

  alias Scriptdrop.Account

  describe "users" do
    alias Scriptdrop.Coherence.User

    @valid_attrs %{roles: "pharmacist", name: "abe", email: "email@example.com", password: "supersecretpassword", confirm_password: "supersecretpassword"}
    @invalid_attrs %{roles: nil, email: "bademail@bad", password: "short", confirm_password: "shot" }

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


    test "create_user/1 validates a correct role" do
      assert {:error, %Ecto.Changeset{}} = Account.create_user(Map.put(@valid_attrs, :roles, "pilot"))
    end
  end
end