defmodule Nurse.Repo.Migrations.AlterTableImage do
  use Ecto.Migration

  def change do
    alter table(:image) do
      add :content_type, :string
      add :path, :string
      add :name, :string
      # add :name, :string
    end
  end
end
