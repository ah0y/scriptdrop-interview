defmodule Scriptdrop.AddressFactory do
  defmacro __using__(_opts) do
    quote do
      def address_factory do
        %Scriptdrop.Location.Address{
          city: "some city",
          state: "some state",
          street: "some street",
          zip: 43205
        }
      end
    end
  end
end