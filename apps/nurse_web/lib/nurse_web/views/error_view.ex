defmodule NurseWeb.ErrorView do
  use NurseWeb, :view
  require Logger

  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  def render("enhanced_error.json", %{error: error}) do
    %{
      status: :error,
      error: Map.take(error, ~w(description properties type title)a)
    }
  end

  def render("changeset_errors.json", %{changeset: errors}) do
    %{
      status: :error,
      error: traverse_errors(errors)
    }
  end

  def render("error.json", %{error: errors}) do
    %{
      status: :error,
      error: PwHelper.View.Success.status_ok(errors, "errors")
    }
  end

  defp traverse_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, _value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(msg))
      end)
    end)
  end
end
