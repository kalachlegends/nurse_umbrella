defmodule Nurse.Services.Tab do
  alias Nurse.Doc

  def create_tab(doc_id, user_id) do
    {:ok, doc} = Doc.get(%{id: doc_id})
    anemesis = regex(doc.doc["anemesis"])
    exam = regex(doc.doc["exam"])
    etc = regex(doc.doc["etc"])
    object_data = regex(doc.doc["object_data"])

    [anemesis, exam, etc, object_data]
    |> Enum.map(fn list ->
      Enum.map(1..(length(list) - 1), &(Enum.at(list, &1 - 1) <> " " <> Enum.at(list, &1)))
    end)
    |> List.flatten()
    |> Enum.map(fn word ->
      with {:ok, tab} <- Nurse.Tab.get(%{words: word}),
           {:ok, _struct} <- Nurse.Tab.update(tab, %{count: tab.count + 1}) do
        :ok
      else
        {:error, _} -> Nurse.Tab.add(%{words: word, count: 1, user_id: user_id})
      end
    end)
  end

  def regex(str) do
    Regex.replace(~r/(\d[^ ]*?[^ ]\ )|([^\wа-я .,]+)/iu, str, " ")
    |> String.replace(~r/\ \ /, " ")
    |> String.downcase()
    |> String.split()
  end

  import Ecto.Query

  def get_ordered(user_id) do
    Nurse.Repo.all(
      from t in Nurse.Tab,
        where: t.user_id == ^user_id,
        order_by: [desc: t.count],
        select: %{name: t.words, change: t.words, selected: false}
    )
  end
end
