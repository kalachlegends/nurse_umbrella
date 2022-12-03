defmodule Nurse.Repo.Migrations.CreateDocs do
  use Ecto.Migration

  def change do
    create table(:docs) do
      add :title, :string
      add :doc, :map
      add :user_id, references(:user, on_delete: :nothing)

      timestamps()
    end

    create index(:docs, [:user_id])
  end
end
