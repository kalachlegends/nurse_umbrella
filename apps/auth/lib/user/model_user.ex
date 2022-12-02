defmodule Auth.Model.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user" do
    field(:data, :map)
    field(:email, :string)
    field(:password, :string)
    field(:login, :string)
    field(:repassword, :string, virtual: true)
    timestamps()
  end

  use Auth.RepoBase, repo: Auth.Repo
  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :data, :login, :repassword])
    |> validate_required([:email, :password, :data, :login])
    |> validate_format(:email, ~r/@/, message: "Введите валидный email")
    |> validate_length(:password,
      min: 4,
      max: 32,
      message: "Пароль не может быть меньше 4 и не больше 32"
    )
    |> validate_length(:login,
      min: 4,
      max: 32,
      message: "Логин не может быть меньше 4 и не больше 32"
    )
    |> unique_constraint(:login, name: :user_login_index, message: "Логин должен быть уникальным")
    |> unique_constraint(:email, name: :user_email_index, message: "Емайл должен быть уникальным")
    |> PwHelper.Changeset.password_check(:password, :repassword)
    |> PwHelper.Changeset.map_validate_check(:data, ["img", "name"])
    |> change(password: PwHelper.Hash.hash(attrs[:password] || attrs["password"]))
  end

  def changeset_profile(struct, params \\ %{}) do
    struct
    |> cast(params, [:data])
    |> PwHelper.Changeset.map_validate_check(:data, ["img", "name"])
  end

  def update_profile(item, opts) do
    item
    |> changeset_profile(opts_to_map(opts))
    |> Auth.Repo.update()
  end
end
