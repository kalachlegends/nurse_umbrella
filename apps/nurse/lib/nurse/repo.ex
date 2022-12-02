defmodule Nurse.Repo do
  use Ecto.Repo,
    otp_app: :nurse,
    adapter: Ecto.Adapters.Postgres

  import Ecto.Query

  def pagination(query, page, limit) do
    limit = limit_pagination(limit)

    if is_nil(page) do
      {query, nil}
    else
      page = check_bitstring_and_convert_int(page) - 1
      offset = page * limit
      count = aggregate(query, :count, :id)

      item = query |> limit(^limit) |> offset(^offset)
      {item, count}
    end
  end

  def search(query, search_value) do
    query |> where([item], like(item, ^search_value))
  end

  defp limit_pagination(limit) do
    if is_nil(limit) do
      10
    else
      check_bitstring_and_convert_int(limit)
    end
  end

  defp check_bitstring_and_convert_int(type) do
    cond do
      is_bitstring(type) -> String.to_integer(type)
      is_integer(type) -> type
      true -> throw("Unkown_type_for_pagination")
    end
  end
end
