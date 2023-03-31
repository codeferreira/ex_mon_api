defmodule ExMonApi.Trainer.Delete do
  alias ExMonApi.{Repo, Trainer}
  alias Ecto.UUID

  def call(id) do
    case UUID.cast(id) do
      {:error} -> {:error, "Invalid UUID"}
      {:ok, uuid} -> delete_trainer(uuid)
    end
  end

  defp delete_trainer(id) do
    case fetch_trainer(id) do
      nil -> {:error, "Trainer not found"}
      trainer -> Repo.delete(trainer)
    end
  end

  defp fetch_trainer(id), do: Repo.get(Trainer, id)
end
