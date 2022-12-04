defmodule NurseWeb.PageController do
  use NurseWeb, :controller
  action_fallback NurseWeb.FallbackController

  def index(conn, params) do
    conn
    |> put_resp_header("content-type", "text/html; charset=utf-8")
    |> put_session(:token, params["token"])
    |> send_file(200, "apps/nurse_web/priv/app/index.html")
    |> halt()
  end

  def receive_doc(%{assigns: assigns}, params) do
    receive_(false, params, assigns)
  end

  def send_doc(%{assigns: assigns}, %{"id" => id}) do
    send_(false, assigns, id)
  end

  def list_doc(%{assigns: assigns}, _params) do
    list_(false, assigns)
  end

  def receive_temp(%{assigns: assigns}, params) do
    receive_(true, params, assigns)
  end

  def send_temp(%{assigns: assigns}, %{"id" => id}) do
    send_(true, assigns, id)
  end

  def list_temp(%{assigns: assigns}, _params) do
    list_(true, assigns)
  end

  def update_temp(%{assigns: assigns}, %{"id" => id} = params) do
    with {:ok, data} <- Nurse.Doc.get(id: id, user_id: assigns.user_id, is_template: true),
         {:ok, data} <-
           Nurse.Doc.update(data, %{
             title: params["title"],
             user_id: assigns.user_id,
             is_template: true,
             doc: Map.drop(params, ["version", "title", "id"])
           }) do
      {:render, %{data: Enum.map(data, &Map.merge(&1.doc, %{title: &1.title, id: &1.id}))}}
    end
  end

  def receive_(is_template, params, assigns) do
    {:ok, doc} =
      Nurse.Doc.add(%{
        title: params["title"],
        user_id: assigns.user_id,
        is_template: is_template,
        doc: Map.drop(params, ["version", "title"])
      })

    {:render,
     %{
       data: [
         %{name: "balls", change: "bowling", selected: false},
         %{name: "bowling", change: "balls", selected: false}
       ],
       anemesis: Regex.replace(~r/(\d[^ ]*?[^ ]\ )|([^\wа-я .,]+)/iu, params["anemesis"], ""),
       object_data:
         Regex.replace(~r/(\d[^ ]*?[^ ]\ )|([^\wа-я .,]+)/iu, params["object_data"], ""),
       exam: Regex.replace(~r/(\d[^ ]*?[^ ]\ )|([^\wа-я .,]+)/iu, params["exam"], "")
     }}

    Nurse.Services.Tag.create_tag(doc.id, assigns.user_id)
    Nurse.Services.Tab.create_tab(doc.id, assigns.user_id)
  end

  def send_(is_template, assigns, id) do
    with {:ok, map} <- Nurse.Doc.get(id: id, user_id: assigns.user_id, is_template: is_template) do
      {:render, %{data: Map.merge(map.doc, %{title: map.title, id: map.id})}}
    end
  end

  def list_(is_template, assigns) do
    with data <- Nurse.Doc.get_all!(user_id: assigns.user_id, is_template: is_template) do
      {:render, %{data: Enum.map(data, &Map.merge(&1.doc, %{title: &1.title, id: &1.id}))}}
    end
  end

  def send_autocomp(_conn, _params) do
    {:render,
     %{
       data: [
         %{name: "balls", change: "bowling", selected: false},
         %{name: "bowling", change: "balls", selected: false}
       ]
     }}
  end

  def get_snippets(%{assigns: assigns}, _params) do
    with {:ok, snippets} <- Nurse.Snippet.get_all(%{user_id: assigns.user_id}),
         list <- Enum.map(snippets, &%{name: &1.name, change: &1.words}) do
      {:render, %{snippets: list}}
    end
  end

  def insert_snippet(%{assigns: assigns}, params) do
    with {:ok, struct} <-
           Nurse.Snippet.add(%{
             name: params["name"],
             words: params["change"],
             count: 1,
             user_id: assigns.user_id
           }) do
      {:render, %{data: struct}}
    end
  end

  def all_content(%{assigns: %{user_id: user_id}}, _params) do
    with {:ok, snippets} <- Nurse.Snippet.get_all(%{user_id: user_id}),
         list <- Enum.map(snippets, &%{name: &1.name, change: &1.words, selected: false}) do
      {:render,
       %{
         content:
           Nurse.Services.Tab.get_ordered(user_id) +
             list +
             Nurse.Services.Tag.get_ordered(user_id)
       }}
    end
  end

  def last_six_docs(%{assigns: %{user_id: user_id}}, _params) do
    doc_list =
      Nurse.Doc.order_by_inserted_at(user_id)
      |> Enum.map(fn doc ->
        Map.from_struct(doc)
        Map.drop(doc, [:__meta__, :__struct__])
      end)
      |> Enum.chunk_every(6)

    {:render, %{doc_list: hd(doc_list)}}
  end
end
