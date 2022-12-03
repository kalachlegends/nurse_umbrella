defmodule Nurse.Word do
  use Ecto.Schema
  import Ecto.Changeset

  schema "words" do
    field :count, :integer
    field :word, :string
    field :user_id, :id

    timestamps()
  end

  use Nurse.Use.RepoBase, repo: Nurse.Repo

  @doc false
  def changeset(word, attrs) do
    word
    |> cast(attrs, [:word, :count])
    |> validate_required([:word, :count])
  end
end
