defmodule LiveviewPubsubDemoWeb.PageController do
  use LiveviewPubsubDemoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
