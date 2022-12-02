defmodule AuthTest do
  use ExUnit.Case

  test "register_user" do
    assert {:error, errors} = Auth.Service.User.register("email", "1234", "1234", "login", %{})

    assert {:ok, _, _} =
             Auth.Service.User.register("ema123asasil@", "1234", "1234", "1243", %{
               "name" => "",
               "img" => ""
             })

    assert {:error, _} = Auth.Service.User.register("email@asd", "1234", "1234", "login", %{})
  end
end
