defmodule ModermodemetWeb.PageControllerTest do
  use ModermodemetWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert true
  end
end
