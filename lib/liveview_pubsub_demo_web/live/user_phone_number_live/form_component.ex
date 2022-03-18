defmodule LiveviewPubsubDemoWeb.UserPhoneNumberLive.FormComponent do
  use LiveviewPubsubDemoWeb, :live_component

  alias LiveviewPubsubDemo.ContactInfo

  @impl true
  def update(%{user_phone_number: user_phone_number} = assigns, socket) do
    changeset = ContactInfo.change_user_phone_number(user_phone_number)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"user_phone_number" => user_phone_number_params}, socket) do
    changeset =
      socket.assigns.user_phone_number
      |> ContactInfo.change_user_phone_number(user_phone_number_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"user_phone_number" => user_phone_number_params}, socket) do
    save_user_phone_number(socket, socket.assigns.action, user_phone_number_params)
  end

  defp save_user_phone_number(socket, :edit, user_phone_number_params) do
    case ContactInfo.update_user_phone_number(socket.assigns.user_phone_number, user_phone_number_params) do
      {:ok, _user_phone_number} ->
        {:noreply,
         socket
         |> put_flash(:info, "User phone number updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_user_phone_number(socket, :new, user_phone_number_params) do
    case ContactInfo.create_user_phone_number(user_phone_number_params) do
      {:ok, _user_phone_number} ->
        {:noreply,
         socket
         |> put_flash(:info, "User phone number created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
