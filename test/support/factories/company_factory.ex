defmodule Scriptdrop.PharmacyFactory do
  defmacro __using__(_opts) do
    quote do
      def pharmacy_factory do
        %Scriptdrop.Company.Pharmacy{
          name: "some pharmacy",
          address: build(:address),
        }
      end
    end
  end
end

defmodule Scriptdrop.CourierFactory do
  defmacro __using__(_opts) do
    quote do
      def courier_factory do
        %Scriptdrop.Company.Courier{
          name: "some courier",
          address: build(:address),
        }
      end
    end
  end
end



