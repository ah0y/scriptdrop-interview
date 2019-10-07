defmodule ScriptdropWeb.PageController do
  use ScriptdropWeb, :controller

  def index(conn, _params, user) do
    if user do
      redirect(conn, to: Routes.order_path(conn, :index))
    else
      render(conn, "index.html")
    end
  end

  def action(conn, _) do
    apply(
      __MODULE__,
      action_name(conn),
      [conn, conn.params, conn.assigns.current_user]
    )
  end
end
