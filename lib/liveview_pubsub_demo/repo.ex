defmodule LiveviewPubsubDemo.Repo do
  use Ecto.Repo,
    otp_app: :liveview_pubsub_demo,
    adapter: Ecto.Adapters.Postgres
end
