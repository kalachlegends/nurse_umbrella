defmodule Auth.Repo.Migrations.User do
  use Ecto.Migration

  def change do
    create table(:user) do
      add(:login, :string)
      add(:email, :string)
      add(:password, :string)
      add(:data, :map)

      timestamps()
    end

    create(unique_index(:user, [:email]))
    create(unique_index(:user, [:login]))
  end
end
