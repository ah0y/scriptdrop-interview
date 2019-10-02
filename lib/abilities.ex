alias Scriptdrop.Coherence.User
alias Scriptdrop.Company.{Courier, Pharmacy}
alias Scriptdrop.Customer.{Order, Patient}
alias Scriptdrop.Location.{Address}
alias Scriptdrop.Repo

defimpl Canada.Can, for: User do
  def can?(%User{id: user_id_1}, action, %User{id: user_id_2})
      when action in [:show, :edit, :update] do
    user_id_1 == user_id_2
  end

  def can?(%User{pharmacy_id: id, roles: "pharmacist"}, action, %Order{pharmacy_id: id})
      when action in [:show, :edit, :update] do
    true
  end

  def can?(%User{courier_id: courier_id, roles: "courier"}, action, order = %Order{})
      when action in [:show, :edit, :update] do
    order = order |> Repo.preload([{:pharmacy, :courier}])
      courier_id == order.pharmacy.courier_id
  end

  def can?(%User{roles: "pharmacist"}, action, Order)
      when action in [:new, :create] do
    true
  end

  def can?(%User{courier_id: id, roles: "courier"}, action, Order)
      when action in [:index] do
    true
  end

  def can?(%User{pharmacy_id: id, roles: "pharmacist"}, action, Order)
      when action in [:index] do
    true
  end

  def can?(%User{roles: "pharmacist"}, action, Patient)
      when action in [:new, :create] do
    true
  end

  def can?(%User{roles: "pharmacist"}, action, %Patient{})
      when action in [:edit, :update, :show] do
    true
  end

  def can?(%User{courier_id: courier_id, roles: "courier"}, action, %Courier{id: courier_id_2})
      when action in [:edit, :update, :delete] do
    courier_id == courier_id_2
  end

  def can?(%User{}, action, %Courier{})
      when action in [:show] do
    true
  end

  def can?(%User{}, action, Courier)
      when action in [:index] do
    true
  end

  def can?(%User{courier_id: id, roles: "courier"}, action, Courier)
      when action in [:new, :create] do
    true
  end

  def can?(%User{pharmacy_id: pharmacy_id, roles: "pharmacist"}, action, %Pharmacy{id: pharmacy_id_2})
      when action in [:edit, :update, :delete] do
    pharmacy_id == pharmacy_id_2
  end

  def can?(%User{}, action, %Pharmacy{})
      when action in [:show] do
    true
  end

  def can?(%User{}, action, Pharmacy)
      when action in [:index] do
    true
  end

  def can?(%User{pharmacy_id: id, roles: "pharmacy"}, action, pharmacy)
      when action in [:new, :create] do
    true
  end

  def can?(%User{}, _, _), do: false
end

defimpl Canada.Can, for: Atom do
  def can?(nil, _, _), do: false
end

