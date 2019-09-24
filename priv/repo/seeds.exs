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
  %Scriptdrop.Company.Pharmacy{
    name: "Better Rx",
    address: %Scriptdrop.Location.Address{
      street: "1275 kinnear road",
      city: "columbus",
      state: "oh",
      zip: 43215
    }
  }
)

Scriptdrop.Repo.insert!(
  %Scriptdrop.Company.Pharmacy{
    name: "Best Rx",
    address: %Scriptdrop.Location.Address{
      street: "123 Austin St",
      city: "Austin",
      state: "tx",
      zip: 78702
    }
  }
)


Scriptdrop.Repo.insert!(
  %Scriptdrop.Company.Pharmacy{
    name: "Drugs R Us",
    address: %Scriptdrop.Location.Address{
      street: "4925 LA Ave",
      city: "los angeles",
      state: "ca",
      zip: 90056
    }
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
    }
  }
)


Scriptdrop.Repo.insert!(
  %Scriptdrop.Company.Courier{
    name: "Previous Day Delivery",
    address: %Scriptdrop.Location.Address{
      street: "7433 LA Ct",
      city: "los angeles",
      state: "ca",
      zip: 90056
    }
  }
)

#Scriptdrop.Repo.insert!(
#  %Scriptdrop.Coherence.User{
#    name: "abe",
#    email: "abe200@gmail.com",
#    password: "password",
#    password_hash: "$2b$12$yPfPx1nWGe3yb/UfLfPy.Op9REGVuZbVze85heRgsu9uAVj7/MTUK",
##    pharmacy_id: 1
#        roles: [
#      %Scriptdrop.Account.Role{
##        name: "pharmacy",
#        pharmacy_id: 1
#      }
#    ]
#  }
#)

#import Ecto.Changeset
#
#changeset = Scriptdrop.Coherence.User.changeset(
#  %Scriptdrop.Coherence.User{},
#  %{
#    name: "abe",
#    email: "abe03@gmail.com",
#    password: "password",
#    password_hash: "$2b$12$yPfPx1nWGe3yb/UfLfPy.Op9REGVuZbVze85heRgsu9uAVj7/MTUK",
#    pharmacy_id: 1
#    #   roles: [
#    #      %Scriptdrop.Account.Role{
#    #        name: "pharmacy",
#    #        pharmacy_id: 1
#    #      }
#    #    ]
#  }
#)
#
#changeset = model
#            |> Ecto.Changeset.change()
#            |> Ecto.Changeset.put_assoc(
#                 :roles,
#                 [%Scriptdrop.Account.Role{name: "so-so example!", pharmacy_id: 1} | model.roles]
#               )
#
#               break! Scriptdrop.Account.Role.changeset/2