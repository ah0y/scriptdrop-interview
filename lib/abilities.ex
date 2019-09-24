#alias Scriptdrop.Coherence.User
#alias Scriptdrop.Company.{Courier, Pharmacy}
#alias Scriptdrop.Customer.{Order, Patient}
#alias Scriptdrop.Location.{Address}
#alias Scriptdrop.Repo
#
#defimpl Canada.Can, for: User do
#
#  def can?(%User{pharmacy_id: id, is_pharmacy?: true}, action, %Order{pharmacy_id: id})
#      when action in [:show, :edit, :update] do
#    true
#  end
#
#  def can?(%User{courier_id: id, is_pharmacy?: false}, action, %Order{courier_id: id})
#      when action in [:show, :edit, :update] do
#    true
#  end
#
#  def can?(%User{is_pharmacy?: true}, action, Order)
#      when action in [:new, :create] do
#    true
#  end
#
#  def can?(%User{is_pharmacy?: true}, action, Patient)
#      when action in [:index, :new, :create] do
#    true
#  end
#
#  def can?(%User{is_pharmacy?: true}, action, %Patient{})
#      when action in [:edit, :update] do
#    true
#  end
#
#  def can?(%User{}, action, %Patient{})
#      when action in [:show] do
#    true
#  end
#
##  def can?(%User{}, :show, %Order{}), do: true
##  def can?(%User{}, :index, Order), do: true
##
##  def can?(%User{}, :show, %Patient{}), do: true
##  def can?(%User{}, :index, Patient), do: true
#
#
#  def can?(%User{}, action, %Courier{})
#      when action in [:show, :edit, :update, :delete] do
#    true
#  end
#
#  def can?(%User{}, action, Courier)
#      when action in [:index, :new, :create] do
#    true
#  end
#
#  def can?(%User{}, action, %Pharmacy{})
#      when action in [:show, :edit, :update, :delete] do
#    true
#  end
#
#  def can?(%User{}, action, Pharmacy)
#      when action in [:index, :new, :create] do
#    true
#  end
#
#  def can?(%User{}, _, _), do: false
#end
#
#defimpl Canada.Can, for: Atom do
##  def can?(nil, :show, %Book{}), do: true
##  def can?(nil, :index, Book), do: true
##
##  def can?(nil, :show, %Library{}), do: true
##  def can?(nil, :index, Library), do: true
##
##  def can?(nil, :show, %Author{}), do: true
##  def can?(nil, :index, Author), do: true
#
#  def can?(nil, _, _), do: false
#end
#
