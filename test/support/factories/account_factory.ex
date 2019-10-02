defmodule Scriptdrop.UserFactory do

  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %Scriptdrop.Coherence.User{
          name: "some user",
          email: sequence(:email, &"me-#{&1}@foo.com"),
          password: "password",
          password_hash: "$2b$12$XLGRLrhRbzLiicATx7Zihe2hXdqrkpbN4cSwD.w0e/LpZtvh.TkcS",
        }
      end

      def pharmacist_user_factory do
        %Scriptdrop.Coherence.User{
          name: "some pharmacist user",
          email: sequence(:email, &"me-#{&1}@foo.com"),
          password: "password",
          password_hash: "$2b$12$XLGRLrhRbzLiicATx7Zihe2hXdqrkpbN4cSwD.w0e/LpZtvh.TkcS",
          pharmacy: build(:pharmacy)
        }
      end

      def courier_user_factory do
        %Scriptdrop.Coherence.User{
          name: "some courier user",
          email: sequence(:email, &"me-#{&1}@foo.com"),
          password: "password",
          password_hash: "$2b$12$XLGRLrhRbzLiicATx7Zihe2hXdqrkpbN4cSwD.w0e/LpZtvh.TkcS",
        }
      end
    end
  end
end