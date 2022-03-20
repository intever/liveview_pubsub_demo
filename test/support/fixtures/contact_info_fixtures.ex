defmodule LiveviewPubsubDemo.ContactInfoFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveviewPubsubDemo.ContactInfo` context.
  """

  import LiveviewPubsubDemo.AccountsFixtures

  alias LiveviewPubsubDemo.ContactInfo.UserPhoneNumber

  @doc """
  Generate a user_phone_number.
  """
  def user_phone_number_fixture(attrs \\ %{}) do
    user = attrs[:user] || user_fixture()

    attrs = attrs
    |> Enum.into(%{
      phone_number: "some phone_number",
    })

    {:ok, user_phone_number} =
      %UserPhoneNumber{user_id: user.id}
      |> LiveviewPubsubDemo.ContactInfo.create_user_phone_number(attrs)

    user_phone_number
  end
end
