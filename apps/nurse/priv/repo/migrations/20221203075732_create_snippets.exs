defmodule Nurse.Repo.Migrations.CreateSnippets do
  use Ecto.Migration

  def change do
    create table(:snippets) do
      add :words, :string
      add :count, :integer, default: 0
      add :user_id, references(:user, on_delete: :nothing)
    end

    create index(:snippets, [:user_id])
  end
end
