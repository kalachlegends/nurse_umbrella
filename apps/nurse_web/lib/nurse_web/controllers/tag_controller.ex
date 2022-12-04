defmodule NurseWeb.TagController do
  use NurseWeb, :controller
  action_fallback NurseWeb.FallbackController

  def send_tag(%{assigns: %{user_id: user_id}}, _params) do
    {:render, %{data: Nurse.Services.Tag.get_ordered(user_id)}}
  end
end
