defmodule LiveviewPubsubDemoWeb.UserPhoneNumberLive.Index do
  use LiveviewPubsubDemoWeb, :live_view

  alias LiveviewPubsubDemo.ContactInfo
  alias LiveviewPubsubDemo.ContactInfo.UserPhoneNumber

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :user_phone_number_collection, list_user_phone_number())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit User phone number")
    |> assign(:user_phone_number, ContactInfo.get_user_phone_number!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New User phone number")
    |> assign(:user_phone_number, %UserPhoneNumber{user_id: socket.assigns.current_user.id})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing User phone number")
    |> assign(:user_phone_number, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    user_phone_number = ContactInfo.get_user_phone_number!(id)
    {:ok, _} = ContactInfo.delete_user_phone_number(user_phone_number)

    {:noreply, assign(socket, :user_phone_number_collection, list_user_phone_number())}
  end

  defp list_user_phone_number do
    ContactInfo.list_user_phone_number()
  end
end
