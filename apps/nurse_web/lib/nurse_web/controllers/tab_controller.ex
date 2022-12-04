defmodule NurseWeb.TabController do
  use NurseWeb, :controller
  action_fallback NurseWeb.FallbackController

  def send_tabs(%{assigns: %{user_id: user_id}}, _params) do
    {:render, %{data: Nurse.Services.Tab.get_ordered(user_id)}}
  end

  def popular_tabs(%{assigns: %{user_id: user_id}}, _params) do
    popular_tabs = Nurse.Services.Tab.get_ordered(user_id)
    |> Enum.chunk_every(30)
    {:render, %{data: hd(popular_tabs), count: Enum.count(hd(popular_tabs))}}
  end
end
