defmodule LiveviewPubsubDemo.ContactInfoFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveviewPubsubDemo.ContactInfo` context.
  """

  @doc """
  Generate a user_phone_number.
  """
  def user_phone_number_fixture(attrs \\ %{}) do
    {:ok, user_phone_number} =
      attrs
      |> Enum.into(%{
        phone_number: "some phone_number"
      })
      |> LiveviewPubsubDemo.ContactInfo.create_user_phone_number()

    user_phone_number
  end
end
