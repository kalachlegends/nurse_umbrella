defmodule Nurse.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tag" do
    field :name, :string
    field :user_id, :id
  end

  use Nurse.Use.RepoBase, repo: Nurse.Repo

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name, :user_id])
  end
end
