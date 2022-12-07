defmodule NurseWeb.TabController do
  use NurseWeb, :controller
  action_fallback NurseWeb.FallbackController

  def send_tabs(%{assigns: %{user_id: user_id}}, _params) do
    {:render, %{data: Nurse.Services.Tab.get_ordered(user_id)}}
  end

  def popular_tabs(%{assigns: %{user_id: user_id}}, _params) do
    popular_tabs = Nurse.Services.Tab.get_ordered(user_id, :popular)

    {:render, %{data: popular_tabs}}
  end
end
