defmodule ExMonApi.Trainer do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "trainers" do
    field(:name, :string)
    field(:password_hash, :string)
    field(:password, :string, virtual: true)
    timestamps()
  end

  @required_fields [:name, :password]

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> validate_length(:password, min: 6)
    |> handle_password_hash()
  end

  def handle_password_hash(
        %Ecto.Changeset{
          valid?: true,
          changes: %{password: password}
        } = changeset
      ) do
    change(changeset, Argon2.add_hash(password))
  end

  def handle_password_hash(changeset), do: changeset
end
