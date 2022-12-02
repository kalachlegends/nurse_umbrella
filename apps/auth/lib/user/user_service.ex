defmodule Auth.Service.User do
  alias Auth.{Repo, Token}
  import Ecto.Query
  alias Auth.Model.User

  def update(id, map) do
    with {:ok, _id} <- Auth.not_nil(id, "id parametr not found"),
         {:ok, map} <- Auth.not_nil(map, "user parametr not found"),
         {:ok, vendor_sturct} <- User.get(id),
         {:ok, user} <-
           User.update_profile(vendor_sturct, map) do
      {:ok, user |> Map.delete(:password)}
    end
  end

  def login(login, password \\ "") do
    password = PwHelper.Hash.hash(password)

    query =
      from(
        user in User,
        where: user.login == ^login and user.password == ^password,
        select: [:id, :login, :email, :data]
      )

    user = Repo.one(query)

    if !is_nil(user) do
      token = Token.generate_and_sign!(%{"user_id" => user.id})

      {:ok, user, token}
    else
      {:error, "login or password not valid"}
    end
  end

  def register(email, password, repassword, login, _data) do
    case Repo.insert(
           User.changeset(%User{}, %{
             email: email,
             password: password,
             repassword: repassword,
             login: login,
             data: %{"img" => "", "name" => ""}
           })
         ) do
      {:ok, struct} ->
        token = Token.generate_and_sign!(%{"user_id" => struct.id})
        user = struct |> Map.delete(:password) |> Map.delete(:repassword)
        {:ok, user, token}

      {:error, reason} ->
        {:error, reason}
    end
  end

  def get_user_by_token(token) do
    with {:ok, claims} <- Token.verify_and_validate(token),
         {:ok, user} <- User.get(claims["user_id"]) do
      user = user |> Map.delete(:password)
      {:ok, user}
    end
  end

  def search_by_login(login) do
    login = "#{login}%"

    from(
      user in User,
      where: like(user.login, ^login),
      select: [:id, :login, :email, :data]
    )
    |> Repo.all([])
  end

  def get_all_users_by_list(list) do
    from(
      user in User,
      where: user.id in ^list,
      select: [:id, :login, :email, :data]
    )
    |> Repo.all([])
  end

  def get_by(login, :login) do
    from(
      user in User,
      where: user.login == ^login,
      select: [:id, :login, :email, :data]
    )
    |> Repo.one()
    |> Auth.not_found()
  end

  def get_by(id) do
    from(
      user in User,
      where: user.id == ^id,
      select: [:id, :login, :email, :data]
    )
    |> Repo.one([])
    |> Auth.not_found()
  end
end
