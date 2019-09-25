# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Scriptdrop.Repo.insert!(%Scriptdrop.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.



Scriptdrop.Repo.insert!(

  %Scriptdrop.Company.Courier{
    name: "Previous Day Delivery",
    address: %Scriptdrop.Location.Address{
      street: "7433 LA Ct",
      city: "los angeles",
      state: "ca",
      zip: 90056
    },
    pharmacies: [
      %Scriptdrop.Company.Pharmacy{
        name: "Drugs R Us",
        address: %Scriptdrop.Location.Address{
          street: "4925 LA Ave",
          city: "los angeles",
          state: "ca",
          zip: 90056
        }
      }
    ]
  }
)


Scriptdrop.Repo.insert!(
  %Scriptdrop.Company.Courier{
    name: "Same Day Delivery",
    address: %Scriptdrop.Location.Address{
      street: "900 Trenton Lane",
      city: "Trenton",
      state: "NJ",
      zip: 08536
    },
    pharmacies: [
      %Scriptdrop.Company.Pharmacy{
        name: "Best Rx",
        address: %Scriptdrop.Location.Address{
          street: "123 Austin St",
          city: "Austin",
          state: "tx",
          zip: 78702
        }
      },

      %Scriptdrop.Company.Pharmacy{
        name: "Better Rx",
        address: %Scriptdrop.Location.Address{
          street: "1275 kinnear road",
          city: "columbus",
          state: "oh",
          zip: 43215
        }
      }
    ]
  }
)


#import Ecto.Changeset
#
#changeset = Scriptdrop.Coherence.User.changeset(
#  %Scriptdrop.Coherence.User{},
#  %{
#    name: "abe",
#    email: "abe03@gmail.com",
#    password: "password",
#    password_hash: "$2b$12$yPfPx1nWGe3yb/UfLfPy.Op9REGVuZbVze85heRgsu9uAVj7/MTUK",
#    roles: "courier"
#  }
#)
#
#
#break! Scriptdrop.Coherence.User.changeset / 2


#    model |> cast(params, [:roles, :name, :email] ++ coherence_fields()) |> Ecto.Changeset.validate_subset(:roles, ["pharmacist", "courier"])