defmodule Nurse.Doc do
  use Ecto.Schema
  import Ecto.Changeset

  schema "docs" do
    field :doc, :map
    field :title, :string
    field :is_template, :boolean
    field :user_id, :id

    timestamps()
  end

  use Nurse.Use.RepoBase, repo: Nurse.Repo

  @doc false
  def changeset(doc, attrs) do
    doc
    |> cast(attrs, [:title, :doc, :user_id, :is_template])
    |> validate_required([:title, :doc, :user_id, :is_template])
  end
end
