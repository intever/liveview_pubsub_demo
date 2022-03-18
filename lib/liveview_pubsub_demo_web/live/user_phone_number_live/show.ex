defmodule LiveviewPubsubDemoWeb.UserPhoneNumberLive.Show do
  use LiveviewPubsubDemoWeb, :live_view

  alias LiveviewPubsubDemo.ContactInfo

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:user_phone_number, ContactInfo.get_user_phone_number!(id))}
  end

  defp page_title(:show), do: "Show User phone number"
  defp page_title(:edit), do: "Edit User phone number"
end
