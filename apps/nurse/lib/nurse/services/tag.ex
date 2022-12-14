defmodule Nurse.Services.Tag do
  alias Nurse.Doc

  def create_tag(doc_id, user_id) do
    {:ok, doc} = Doc.get(%{id: doc_id})

    doc.doc["report_customer"] || ""
    |> IO.inspect(label: "report_customer")
    |> String.downcase()
    |> String.split(",")
    |> Enum.map(fn tag ->
      with {:ok, _tag} <- Nurse.Tag.get(%{name: tag}) do
        :ok
      else
        {:error, _} -> Nurse.Tag.add(%{name: tag, user_id: user_id})
      end
    end)
  end

  import Ecto.Query

  def get_ordered(user_id) do
    Nurse.Repo.all(
      from t in Nurse.Tag,
        where: t.user_id == ^user_id,
        select: %{name: t.name, change: t.name, selected: false}
    )
  end
end
