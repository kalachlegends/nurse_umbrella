defmodule Nurse.Repo.Migrations.CreateTabs do
  use Ecto.Migration

  def change do
    create table(:tabs) do
      add :words, :string
      add :count, :integer
      add :user_id, references(:user, on_delete: :nothing)
    end

    create index(:tabs, [:user_id])
  end
end
