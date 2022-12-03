defmodule NurseWeb.TabController do
  use NurseWeb, :controller
  action_fallback NurseWeb.FallbackController

  def send_tabs(%{assigns: %{user_id: user_id}}, _params) do
    {:render, %{data: Nurse.Services.Tab.get_ordered(user_id)}}
  end
end
