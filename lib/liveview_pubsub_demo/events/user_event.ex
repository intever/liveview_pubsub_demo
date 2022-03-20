defmodule LiveviewPubsubDemo.Events.UserEvent do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :type, :string
    field :data, :map
    field :event_at, :utc_datetime
    field :user_id, :integer
  end

  @doc false
  def changeset(user_event, attrs) do
    user_event
    |> cast(attrs, [:type, :data, :event_at, :user_id])
    |> validate_required([:type, :data, :event_at, :user_id])
  end
end
