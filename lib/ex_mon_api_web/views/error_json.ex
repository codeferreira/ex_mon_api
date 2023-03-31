defmodule ExMonApiWeb.ErrorJSON do
  import Ecto.Changeset

  def bad_request(%{result: result}) do
    %{message: translate_errors(result)}
  end

  defp translate_errors(changeset) do
    traverse_errors(changeset, fn {msg, opts} ->
      Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)
  end
end
