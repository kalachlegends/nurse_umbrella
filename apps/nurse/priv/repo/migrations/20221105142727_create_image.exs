defmodule Nurse.Repo.Migrations.CreateImage do
  use Ecto.Migration

  def change do
    create table(:image) do
      add :image_url, :string
      add :user_id, references(:user, on_delete: :nothing)

      timestamps()
    end

    create index(:image, [:user_id])
  end
end
