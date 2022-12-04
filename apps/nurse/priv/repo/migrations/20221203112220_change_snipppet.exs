defmodule Nurse.Repo.Migrations.ChangeSnipppet do
  use Ecto.Migration

  def change do
    alter table "snippets" do
      add :name, :string
    end
  end
end
