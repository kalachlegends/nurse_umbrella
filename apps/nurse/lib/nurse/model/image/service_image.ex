defmodule Nurse.Service.Image do
  import Ecto.Query

  alias Nurse.Repo
  alias Nurse.Model.Image
  require PwHelper.Error

  def create(map) do
    Image.changeset(%Image{}, map)
    |> Repo.insert()
  end

  def create(user_id, img) do
    cond do
      is_list(img) -> {Enum.each(img, fn x -> create(:create, user_id, x) end), "list_is_upload"}
      true -> create(:create, user_id, img)
    end
  end

  defp create(:create, user_id, img) do
    with {:ok, path, path_img, img, name} <-
           upload_image(user_id, img) |> PwHelper.Error.return_throw(),
         {:ok, image} <-
           create(%{
             user_id: user_id,
             image_url: path,
             content_type: img.content_type,
             path: path_img,
             name: name
           }),
         {:ok, image} <-
           Image.update(image, image_url: image.image_url <> Integer.to_string(image.id)) do
      {:ok, image |> Map.delete(:path)}
    end
  end

  defp upload_image(user_id, img) do
    if !Regex.match?(~r/image/, img.content_type), do: throw({:error, "File must be an image"})

    if upload = img do
      extension = Path.extname(upload.filename)

      path = "apps/nurse_web/priv/static/uploads/user=#{user_id}-#{random_string(24)}#{extension}"

      {File.cp(upload.path, path), generate_url("uploads/"), path, img, upload.filename}
    else
      {:error, "file_is_nil"}
    end
  end

  def generate_url(path) do
    endpoint_cnf = Application.get_env(:nurse_web, NurseWeb.Endpoint)

    "http://" <>
      endpoint_cnf[:url][:host] <>
      ":" <>
      Integer.to_string(endpoint_cnf[:http][:port]) <>
      "/" <> path
  end

  def get_all(user_id, page, search_name, limit \\ 10) do
    search_name = "%#{search_name}%"

    {images, count} =
      from(
        img in Image,
        where: img.user_id == ^user_id and like(img.name, ^search_name),
        order_by: img.updated_at
      )
      |> Repo.pagination(page, limit)

    images = Repo.all(images, [])
    if [] != images, do: {:ok, images, count}, else: {:error, :not_found}
  end

  def random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64() |> binary_part(0, length)
  end
end
