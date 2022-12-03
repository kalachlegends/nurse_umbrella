defmodule Nurse.Repo.Migrations.CreateWords do
  use Ecto.Migration

  def change do
    create table(:words) do
      add :word, :string
      add :count, :integer
      add :user_id, references(:user, on_delete: :nothing)
    end

    create index(:words, [:user_id])
  end
end
