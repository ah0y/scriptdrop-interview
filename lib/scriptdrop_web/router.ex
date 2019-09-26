defmodule ScriptdropWeb.Router do
  use ScriptdropWeb, :router
  use Coherence.Router         # Add this

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session  # Add this
  end

  # Add this block
  pipeline :protected do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, protected: true
  end

  # Add this block
  scope "/" do
    pipe_through :browser
    coherence_routes()
  end

  # Add this block
  scope "/" do
    pipe_through :protected
    coherence_routes :protected
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ScriptdropWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/csv", CsvController, :index
    resources "/courier", CourierController
    resources "/pharmacy", PharmacyController
    resources "/order", OrderController
    resources "/patient", PatientController
    resources "/address", AddressController
    resources "/user", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", ScriptdropWeb do
  #   pipe_through :api
  # end
end
