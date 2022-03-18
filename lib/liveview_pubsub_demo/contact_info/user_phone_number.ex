defmodule LiveviewPubsubDemo.ContactInfo.UserPhoneNumber do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_phone_number" do
    field :phone_number, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(user_phone_number, attrs) do
    user_phone_number
    |> cast(attrs, [:phone_number])
    |> validate_required([:phone_number])
  end
end
