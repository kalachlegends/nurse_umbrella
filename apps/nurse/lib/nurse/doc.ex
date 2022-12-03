defmodule Nurse.Doc do
  use Ecto.Schema
  import Ecto.Changeset

  schema "docs" do
    field :doc, :map
    field :title, :string
    field :user_id, :id

    timestamps()
  end

  use Nurse.Use.RepoBase, repo: Nurse.Repo

  @doc false
  def changeset(doc, attrs) do
    doc
    |> cast(attrs, [:title, :doc, :user_id])
    |> validate_required([:title, :doc, :user_id])
  end
end
