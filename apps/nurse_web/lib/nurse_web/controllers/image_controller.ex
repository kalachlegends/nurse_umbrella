defmodule NurseWeb.ImageController do
  use NurseWeb, :controller
  action_fallback(NurseWeb.FallbackController)
  alias Nurse.Service.Image, as: ServiceImage
  alias Nurse.Model.Image

  def create(%{assigns: assign}, params) do
    with {:ok, image} <- ServiceImage.create(assign.user_id, params["img"]) do
      {:render, %{image: image}}
    end
  end

  def get_by_id(conn, %{"id" => id}) do
    with {:ok, image} <- Image.get(id) do
      conn
      |> put_resp_header("content-type", image.content_type)
      |> send_file(200, image.path)
      |> halt()
    end
  end

  def all(%{assigns: assign}, params) do
    with {:ok, image, count} <-
           ServiceImage.get_all(
             assign.user_id,
             params["page"],
             params["search_value"],
             params["limit"]
           ) do
      {:render, %{images: image, count: count}}
    end
  end
end
