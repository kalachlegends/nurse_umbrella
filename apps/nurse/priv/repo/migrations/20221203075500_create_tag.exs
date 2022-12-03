defmodule Nurse.Repo.Migrations.CreateTag do
  use Ecto.Migration

  def change do
    create table(:tag) do
      add :name, :string
      add :user_id, references(:user, on_delete: :nothing)
    end

    create index(:tag, [:user_id])
  end
end
