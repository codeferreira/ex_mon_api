defmodule ExMonApiWeb.TrainersController do
  use ExMonApiWeb, :controller

  action_fallback ExMonApiWeb.FallbackController

  def create(conn, params) do
    params
    |> ExMonApi.create_trainer()
    |> handle_status(:created, :bad_request)
    |> handle_create(conn)
  end

  def delete(conn, %{"id" => id}) do
    id
    |> ExMonApi.delete_trainer()
    |> handle_status(:no_content, :not_found)
    |> handle_delete(conn)
  end

  defp handle_delete({:ok, _struct, status}, conn) do
    conn
    |> put_status(status)
    |> text("")
  end

  defp handle_delete({:error, _reason, _status} = error, _conn), do: error

  defp handle_create({:ok, struct, status}, conn) do
    conn
    |> put_status(status)
    |> render(:create, trainer: struct)
  end

  defp handle_create({:error, _changeset, _status} = error, _conn), do: error

  defp handle_status(response, right_status, wrong_status) do
    case response do
      {:ok, struct} -> {:ok, struct, right_status}
      {:error, changeset} -> {:error, changeset, wrong_status}
    end
  end
end
