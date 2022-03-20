defmodule LiveviewPubsubDemo.ContactInfoTest do
  use LiveviewPubsubDemo.DataCase

  alias LiveviewPubsubDemo.ContactInfo

  import LiveviewPubsubDemo.{
    AccountsFixtures,
    ContactInfoFixtures
  }

  describe "user_phone_number" do
    alias LiveviewPubsubDemo.ContactInfo.UserPhoneNumber

    import LiveviewPubsubDemo.ContactInfoFixtures

    @invalid_attrs %{phone_number: nil}

    test "list_user_phone_number/0 returns all user_phone_number" do
      user_phone_number = user_phone_number_fixture()
      assert ContactInfo.list_user_phone_number() == [user_phone_number]
    end

    test "get_user_phone_number!/1 returns the user_phone_number with given id" do
      user_phone_number = user_phone_number_fixture()
      assert ContactInfo.get_user_phone_number!(user_phone_number.id) == user_phone_number
    end

    test "create_user_phone_number/2 with valid data creates a user_phone_number" do
      user = user_fixture()
      user_phone_number = %UserPhoneNumber{user_id: user.id}
      valid_attrs = %{phone_number: "some phone_number"}

      assert {:ok, %UserPhoneNumber{} = user_phone_number} = ContactInfo.create_user_phone_number(user_phone_number, valid_attrs)
      assert user_phone_number.user_id == user.id
      assert user_phone_number.phone_number == "some phone_number"
    end

    test "create_user_phone_number/2 with invalid data returns error changeset" do
      user_phone_number = %UserPhoneNumber{}
      assert {:error, %Ecto.Changeset{}} = ContactInfo.create_user_phone_number(user_phone_number, @invalid_attrs)
    end

    test "update_user_phone_number/2 with valid data updates the user_phone_number" do
      user_phone_number = user_phone_number_fixture()
      update_attrs = %{phone_number: "some updated phone_number"}

      assert {:ok, %UserPhoneNumber{} = user_phone_number} = ContactInfo.update_user_phone_number(user_phone_number, update_attrs)
      assert user_phone_number.phone_number == "some updated phone_number"
    end

    test "update_user_phone_number/2 with invalid data returns error changeset" do
      user_phone_number = user_phone_number_fixture()
      assert {:error, %Ecto.Changeset{}} = ContactInfo.update_user_phone_number(user_phone_number, @invalid_attrs)
      assert user_phone_number == ContactInfo.get_user_phone_number!(user_phone_number.id)
    end

    test "update_user_phone_number/2 with valid data publishes events" do
      Phoenix.PubSub.subscribe(LiveviewPubsubDemo.PubSub, "user-phone-number.*.*")

      user_phone_number = user_phone_number_fixture()
      update_attrs = %{phone_number: "some updated phone_number"}

      assert {:ok, %UserPhoneNumber{} = user_phone_number} = ContactInfo.update_user_phone_number(user_phone_number, update_attrs)

      user_event = %LiveviewPubsubDemo.Events.UserEvent{
        data: %{
          id: user_phone_number.id,
          phone_number: "some updated phone_number",
          user_id: user_phone_number.user_id
        },
        event_at: user_phone_number.updated_at,
        type: "user_phone_number.updated",
        user_id: user_phone_number.user_id
      }

      assert_receive ^user_event
    end

    test "delete_user_phone_number/1 deletes the user_phone_number" do
      user_phone_number = user_phone_number_fixture()
      assert {:ok, %UserPhoneNumber{}} = ContactInfo.delete_user_phone_number(user_phone_number)
      assert_raise Ecto.NoResultsError, fn -> ContactInfo.get_user_phone_number!(user_phone_number.id) end
    end

    test "change_user_phone_number/1 returns a user_phone_number changeset" do
      user_phone_number = user_phone_number_fixture()
      assert %Ecto.Changeset{} = ContactInfo.change_user_phone_number(user_phone_number)
    end
  end
end
