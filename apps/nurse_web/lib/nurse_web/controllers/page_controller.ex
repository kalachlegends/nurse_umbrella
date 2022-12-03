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

  def receive_doc(_conn, _params) do
    {:render, %{data: [%{name: "balls", change: "bowling", selected: false}, %{name: "bowling", change: "balls", selected: false}]}}
  end

  def send_doc(_conn, _params) do
    {:render, %{data: Enum.at(Nurse.Doc.get_all(), 0)}}
  end

  def send_autocomp(_conn, _params) do
    {:render, %{data: [%{name: "balls", change: "bowling", selected: false}, %{name: "bowling", change: "balls", selected: false}]}}
  end

  # def test(conn, params) do
  #   params["token"]
  #   |> IO.inspect(label: "-------------------------->")

  #   conn
  #   |> assign(:token, params["token"])
  #   |> redirect(to: "/")
  # end
end
