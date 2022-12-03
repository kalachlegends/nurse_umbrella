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
         {:ok, data} <- Nurse.Doc.update(data, %{title: params["title"], user_id: assigns.user_id, is_template: true, doc: Map.drop(params, ["version", "title", "id"])}) do
      {:render, %{data: Enum.map(data, &(Map.merge(&1.doc, %{title: &1.title, id: &1.id})))}}
    end
  end

  def receive_(is_template, params, assigns) do
    Nurse.Doc.add(%{title: params["title"], user_id: assigns.user_id, is_template: is_template, doc: Map.drop(params, ["version", "title"])})
    {:render,
     %{
       data: [
         %{name: "balls", change: "bowling", selected: false},
         %{name: "bowling", change: "balls", selected: false}
       ],
       anemesis: Regex.replace(~r/(\d[^ ]*?[^ ]\ )|([^\wа-я .,]+)/iu, params["anemesis"], ""),
       object_data: Regex.replace(~r/(\d[^ ]*?[^ ]\ )|([^\wа-я .,]+)/iu, params["object_data"], ""),
       exam: Regex.replace(~r/(\d[^ ]*?[^ ]\ )|([^\wа-я .,]+)/iu, params["exam"], "")
     }}
  end

  def send_(is_template, assigns, id) do
    with {:ok, map} <- Nurse.Doc.get(id: id, user_id: assigns.user_id, is_template: is_template) do
      {:render, %{data: Map.merge(map.doc, %{title: map.title, id: map.id})}}
    end
  end

  def list_(is_template, assigns) do
    with data <- Nurse.Doc.get_all!(user_id: assigns.user_id, is_template: is_template) do
      {:render, %{data: Enum.map(data, &(Map.merge(&1.doc, %{title: &1.title, id: &1.id})))}}
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

  # def test(conn, params) do
  #   params["token"]
  #   |> IO.inspect(label: "-------------------------->")

  #   conn
  #   |> assign(:token, params["token"])
  #   |> redirect(to: "/")
  # end

  defp get_text() do
    "со слов пациента считает себя больным с 2017 года, когда появился учащенный стул с кровью, проведена ВКС от 13.11.17: эрозивное поражение слепой кишки и участка прямой кишки. НЯК?Крона?гистология №14496-97:эрозивный колит. Фекальный кальпротекин от 22.11.17: 58 мкг/г. После был поставлен на учетс д/з: язвенный колит, наблюдался по м/жительства,старт терапии препаратами 5-АСК. Получал Месалазин (Салофальк) 1.5 гр пер ос и 500 мг ректальные свечи, в течение 2х месяцев,с положительным эффектом. В июне 2018г вновь появление крови в стуле, обратился в августе к гастроэнтерологу. Фекальный кальпротекин от 03.09.18: 16,77 мкг/г. Прием Асакол 2,4гр. Контрольное ВКС от 14.01.2019 - эрозивный проктит, катаральный илеит, гистология №910-14:терминальный илеит-без патологических изменений;слепая – без патологических изменений;ампула прямой – эрозивный колит. К терапии асаколом 1,2гр + добавлена пентаса 1гр ректально. ВКС от 30.07.2019-эндоскопическая +гистологическая ремиссия, терапия в том же объеме. В феврале 2020 г сменас асакола на пентасу в таблетках 2гр/сутки, + свечи также. В мае 2020 ухудшение в виде со слов в виде инфильтрата в области заднего прохода, болезненный при пальпации. Со слов было дренирование инфильтрата, рецидив в июне 2020г. Обратился к проктологу, параректальный свищ? при аноскопии-слизистая с эрозированной поверхностью, контактно кровоточит. Далее образование перианальной области исчезло самостоятельно. 19.06.2020 повторно ВКС- эндоскопические признаки язвенного колита, умеренной степени активности(?), преимущественно слизистой купола слепой кишки,ампулы прямой кишки,единичные очаги поражения восходящего отдела. Гистология №3496-3501: в куполе слепой, восходящем отделе и прямой кишке- язвенный колит, высокой степени активности воспалительного процесса; поперечная – хронический колит, обострение;терминальный илеум- хронический энтерит. Кальпротектин-244, появилась кровь в кале. Далее начат прием асакола 2.4 гр/сутки+пентаса 1гр, на фоне терапии крови не было, фекальный кальпротектин-43 (октябрь), далее гастроэнтерологом/терапевтом доза асакола снижена 1.2 гр+ свечи в режиме выходного дня. Кальпротектин в ноябре 2020-303, декабрь-1719. Асакол 2.4+пентаса 1гр. 19.01.2021-2475 фекальный. В данный момент терапия асакол 3.2гр+пентаса 1гр Цель госпитализации:Данная госпитализация по порталу в плановом порядке для оценки состояния, решения дальнейшей тактики ведения."
  end
end
