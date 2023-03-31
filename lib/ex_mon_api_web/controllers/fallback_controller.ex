defmodule ExMonApiWeb.FallbackController do
  use ExMonApiWeb, :controller

  def call(conn, {:error, result, status}) do
    conn
    |> put_status(status)
    |> put_view(ExMonApiWeb.ErrorJSON)
    |> render(:bad_request, result: result)
  end
end
