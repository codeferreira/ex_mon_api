defmodule ExMonApiWeb.TrainersController do
  use ExMonApiWeb, :controller

  action_fallback ExMonApiWeb.FallbackController

  def create(conn, params) do
    result =
      params
      |> ExMonApi.create_trainer()

    result =
      case result do
        {:ok, struct} -> {:ok, struct, :created}
        {:error, changeset} -> {:error, changeset, :unprocessable_entity}
      end

    handle_response(result, conn)
  end

  defp handle_response({:ok, struct, status}, conn) do
    conn
    |> put_status(status)
    |> render(:create, trainer: struct)
  end

  defp handle_response({:error, _changeset, _status} = error, _conn), do: error
end
