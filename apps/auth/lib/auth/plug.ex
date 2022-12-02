defmodule Auth.Plug do
  import Plug.Conn
  alias Auth.Token
  def init(options), do: options

  def call(conn, _opts \\ %{}) do
    auth = get_req_header(conn, "authorization")

    if auth != [] do
      token =
        hd(auth)
        |> String.replace("Bearer ", "")

      case Token.verify_and_validate(token) do
        {:ok, claims} ->
          conn
          |> assign(:token, token)
          |> assign(:user_id, claims["user_id"])

        {:error, _err} ->
          resp_message(conn, %{status: "error", message: "Auth token not valid"})
      end
    else
      resp_message(conn, %{status: "error", message: "Auth token not find"})
    end
  end

  defp resp_message(conn, map_message) do
    map_message = map_message |> Jason.encode!()

    put_resp_content_type(conn, "application/json; charset=utf-8")
    |> send_resp(401, map_message)
  end
end
