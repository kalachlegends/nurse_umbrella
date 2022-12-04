defmodule Nurse.Doc do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

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

  def order_by_inserted_at(user_id) do
    Nurse.Repo.all(
      from doc in Nurse.Doc,
        where: doc.user_id == ^user_id and doc.is_template == false,
        order_by: [desc: doc.inserted_at],
        select: doc
    )
  end
end
