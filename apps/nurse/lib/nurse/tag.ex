defmodule Nurse.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tag" do
    field :name, :string
    field :user_id, :id

    timestamps()
  end

  use Nurse.Use.RepoBase, repo: Nurse.Repo

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
