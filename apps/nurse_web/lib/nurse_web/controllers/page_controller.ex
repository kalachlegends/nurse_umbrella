defmodule NurseWeb.PageController do
  use NurseWeb, :controller
  action_fallback NurseWeb.FallbackController

  def index(conn, params) do
    conn
    |> put_resp_header("content-type", "text/html; charset=utf-8")
    |> put_session(:token, params["token"])
    |> send_file(200, "apps/nurse_web/priv/app/index.html")
    |> halt()
  end

  # def test(conn, params) do
  #   params["token"]
  #   |> IO.inspect(label: "-------------------------->")

  #   conn
  #   |> assign(:token, params["token"])
  #   |> redirect(to: "/")
  # end
end
