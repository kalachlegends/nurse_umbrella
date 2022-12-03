defmodule Nurse.Snippet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "snippets" do
    field :count, :integer
    field :words, :string
    field :user_id, :id

    timestamps()
  end

  use Nurse.Use.RepoBase, repo: Nurse.Repo
  
  @doc false
  def changeset(snippet, attrs) do
    snippet
    |> cast(attrs, [:words, :count])
    |> validate_required([:words, :count])
  end
end
