defmodule Nurse.Model.Image do
  use Ecto.Schema
  import Ecto.Changeset

  schema "image" do
    field(:image_url, :string)
    field(:content_type, :string)
    field(:user_id, :id)
    field(:path, :string)
    field(:name, :string)
    timestamps()
  end

  use Nurse.Use.RepoBase, repo: Nurse.Repo
  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:image_url, :user_id, :content_type, :path, :name])
    |> validate_required([:image_url, :path])
  end
end
