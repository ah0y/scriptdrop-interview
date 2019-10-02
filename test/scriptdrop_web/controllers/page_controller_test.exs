defmodule ScriptdropWeb.PageControllerTest do
  use ScriptdropWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert redirected_to(conn) == Routes.session_path(conn, :new)
  end
end
