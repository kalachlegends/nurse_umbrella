defmodule NurseWeb.TabController do
  use NurseWeb, :controller
  action_fallback NurseWeb.FallbackController

  def send_tabs(conn, _params) do
    # {:render, %{user_id: }}
  end
end
