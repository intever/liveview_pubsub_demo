defmodule LiveviewPubsubDemo.Repo do
  use Ecto.Repo,
    otp_app: :liveview_pubsub_demo,
    adapter: Ecto.Adapters.Postgres

  def broadcast_transaction(multi) do
    multi
    |> transaction()
    |> broadcast_user_events()
  end

  defp broadcast_user_events({:error, _error, _changeset, _changes} = result), do: result

  defp broadcast_user_events({:ok, data} = result) do
    data
    |> Map.to_list()
    |> Enum.map(fn
      {{:user_event, _}, user_event_tuple} ->
        user_event_tuple

      _ ->
        nil
    end)
    |> Enum.filter(& &1)
    |> Enum.each(fn user_event_tuple ->
      broadcast_user_event(user_event_tuple)
    end)

    result
  end

  defp broadcast_user_event({user_event, topics}) do
    Enum.each(topics, fn topic ->
      Phoenix.PubSub.broadcast(LiveviewPubsubDemo.PubSub, topic, user_event)
    end)
  end
end
