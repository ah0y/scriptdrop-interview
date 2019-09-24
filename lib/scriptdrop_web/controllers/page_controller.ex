defmodule ScriptdropWeb.PageController do
  use ScriptdropWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
