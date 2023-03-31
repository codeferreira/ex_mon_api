defmodule ExMonApiWeb.TrainersJSON do
  def create(%{trainer: %{id: id, name: name, inserted_at: inserted_at}}) do
    %{
      message: "Trainer created successfully",
      trainer: %{
        id: id,
        name: name,
        inserted_at: inserted_at
      }
    }
  end
end
