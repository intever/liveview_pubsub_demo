defmodule LiveviewPubsubDemo.Events do
  import Ecto.Changeset

  alias Ecto.Multi
  alias LiveviewPubsubDemo.Events.UserEvent

  def multi_create_user_event(
        multi,
        id,
        attrs,
        topics \\ []
      ) do
    changeset = %UserEvent{}
    |> UserEvent.changeset(attrs)

    multi
    |> Multi.run({:user_event, id}, fn _repo, _changes ->
      user_event = apply_action!(changeset, :create)

      {:ok, {user_event, topics}}
    end)
  end
end
