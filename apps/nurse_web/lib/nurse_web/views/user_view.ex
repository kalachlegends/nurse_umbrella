defmodule NurseWeb.UserView do
  def render("index.json", data) do
    PwHelper.View.Success.status_ok(data)
  end
end
