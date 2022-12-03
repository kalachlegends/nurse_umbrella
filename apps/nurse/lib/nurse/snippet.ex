defmodule Nurse.Snippet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "snippets" do
    field :count, :integer
    field :words, :string
    field :name, :string
    field :user_id, :id
  end

  use Nurse.Use.RepoBase, repo: Nurse.Repo

  @doc false
  def changeset(snippet, attrs) do
    snippet
    |> cast(attrs, [:words, :count, :user_id, :name])
    |> validate_required([:words, :count, :user_id, :name])
  end
end
