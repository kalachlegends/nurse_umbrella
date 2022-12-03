defmodule Nurse.Repo.Migrations.ChangeSnippet do
  use Ecto.Migration

  def change do
    alter table "docs" do
      add :is_template, :boolean
    end
  end
end
