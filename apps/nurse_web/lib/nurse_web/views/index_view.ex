defmodule NurseWeb.IndexView do
  use NurseWeb, :view

  def render("index.json", data) do
    # IO.inspect(data[:map])

    cond do
      !is_nil(data[:map]) -> PwHelper.View.Success.message_list(data[:map]) |> IO.inspect()
      true -> PwHelper.View.Success.message_list(data)
    end
  end
end
