defmodule Scriptdrop.Factory do
  use ExMachina.Ecto, repo: Scriptdrop.Repo
  use Scriptdrop.UserFactory
  use Scriptdrop.PharmacyFactory
  use Scriptdrop.CourierFactory
  use Scriptdrop.AddressFactory
end