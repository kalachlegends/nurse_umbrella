defmodule Nurse.Tab do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tabs" do
    field :count, :integer
    field :words, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(tab, attrs) do
    tab
    |> cast(attrs, [:words, :count])
    |> validate_required([:words, :count])
  end
end
