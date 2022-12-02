defmodule NurseWeb.FallbackController do
  use NurseWeb, :controller
  alias NurseWeb.ErrorView

  require Logger

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(404)
    |> put_view(ErrorView)
    |> render("404.json")
  end

  # enhanced error
  def call(conn, {:enhanced_error, error_opts}) do
    conn
    |> put_status(error_opts[:status_code] || 422)
    |> put_view(ErrorView)
    |> render("enhanced_error.json", %{error: error_opts})
  end

  # changeset validation errors
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ErrorView)
    |> render("changeset_errors.json", changeset: changeset)
  end

  # enhanced error handler
  def call(conn, {:error2, error}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ErrorView)
    |> render("error2.json", error: error)
  end

  def call(conn, {:render, map_message}) do
    conn
    |> put_view(NurseWeb.IndexView)
    |> render("index.json", map: map_message)
  end

  def call(conn, {:error, reason}) do
    conn
    |> put_status(406)
    |> put_view(ErrorView)
    |> render("error.json", error: reason)
  end

  def call(conn, error) do
    Logger.warn("error_with_no_handler: #{inspect(error)}")

    conn
    |> put_status(500)
    |> put_view(ErrorView)
    |> render("500.json")
  end
end
