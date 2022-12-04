defmodule NurseWeb.UserController do
  use NurseWeb, :controller
  alias Auth.Service.User

  action_fallback NurseWeb.FallbackController

  def register(conn, params) do
    
    with {:ok, struct, token} <-
           User.register(
             params["email"],
             params["password"],
             params["repassword"],
             params["login"],
             params["data"]
           ) do
      {:render, %{token: token, user: struct}}
    end
  end

  def login(conn, params) do
    with {:ok, struct, token} <- User.login(params["login"], params["password"]) do
      {:render, %{token: token, user: struct}}
    end
  end

  def auth_me(%{assigns: assigns}, params) do
    {:render, %{params: params, assigns: assigns}}
  end

  def get_profile(conn, %{"login" => login}) do
    with {:ok, user} <- User.get_by(login, :login) do
      {:render, %{user: user}}
    end
  end

  def search_by_login(conn, %{"login" => login}) do
    with user <- User.search_by_login(login) do
      {:render, %{users: user}}
    end
  end

  def profile_edit(%{assigns: %{user_id: user_id}}, %{"user" => user}) do
    with {:ok, user} <- User.update(user_id, user) do
      {:render, %{user: user}}
    end
  end
end
