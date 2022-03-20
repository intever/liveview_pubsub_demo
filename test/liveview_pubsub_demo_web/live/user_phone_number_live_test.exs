defmodule LiveviewPubsubDemoWeb.UserPhoneNumberLiveTest do
  use LiveviewPubsubDemoWeb.ConnCase

  import Phoenix.LiveViewTest
  import LiveviewPubsubDemo.ContactInfoFixtures

  setup :register_and_log_in_user

  @create_attrs %{phone_number: "some phone_number"}
  @update_attrs %{phone_number: "some updated phone_number"}
  @invalid_attrs %{phone_number: nil}

  defp create_user_phone_number(_) do
    user_phone_number = user_phone_number_fixture()
    %{user_phone_number: user_phone_number}
  end

  describe "Index" do
    setup [:create_user_phone_number]

    test "lists all user_phone_number", %{conn: conn, user_phone_number: user_phone_number} do
      {:ok, _index_live, html} = live(conn, Routes.user_phone_number_index_path(conn, :index))

      assert html =~ "Listing User phone number"
      assert html =~ user_phone_number.phone_number
    end

    test "saves new user_phone_number", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.user_phone_number_index_path(conn, :index))

      assert index_live |> element("a", "New User phone number") |> render_click() =~
               "New User phone number"

      assert_patch(index_live, Routes.user_phone_number_index_path(conn, :new))

      assert index_live
             |> form("#user_phone_number-form", user_phone_number: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#user_phone_number-form", user_phone_number: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.user_phone_number_index_path(conn, :index))

      assert html =~ "User phone number created successfully"
      assert html =~ "some phone_number"
    end

    test "updates user_phone_number in listing", %{conn: conn, user_phone_number: user_phone_number} do
      {:ok, index_live, _html} = live(conn, Routes.user_phone_number_index_path(conn, :index))

      assert index_live |> element("#user_phone_number-#{user_phone_number.id} a", "Edit") |> render_click() =~
               "Edit User phone number"

      assert_patch(index_live, Routes.user_phone_number_index_path(conn, :edit, user_phone_number))

      assert index_live
             |> form("#user_phone_number-form", user_phone_number: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#user_phone_number-form", user_phone_number: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.user_phone_number_index_path(conn, :index))

      assert html =~ "User phone number updated successfully"
      assert html =~ "some updated phone_number"
    end

    test "deletes user_phone_number in listing", %{conn: conn, user_phone_number: user_phone_number} do
      {:ok, index_live, _html} = live(conn, Routes.user_phone_number_index_path(conn, :index))

      assert index_live |> element("#user_phone_number-#{user_phone_number.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#user_phone_number-#{user_phone_number.id}")
    end
  end

  describe "Show" do
    setup [:create_user_phone_number]

    test "displays user_phone_number", %{conn: conn, user_phone_number: user_phone_number} do
      {:ok, _show_live, html} = live(conn, Routes.user_phone_number_show_path(conn, :show, user_phone_number))

      assert html =~ "Show User phone number"
      assert html =~ user_phone_number.phone_number
    end

    test "updates user_phone_number within modal", %{conn: conn, user_phone_number: user_phone_number} do
      {:ok, show_live, _html} = live(conn, Routes.user_phone_number_show_path(conn, :show, user_phone_number))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit User phone number"

      assert_patch(show_live, Routes.user_phone_number_show_path(conn, :edit, user_phone_number))

      assert show_live
             |> form("#user_phone_number-form", user_phone_number: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#user_phone_number-form", user_phone_number: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.user_phone_number_show_path(conn, :show, user_phone_number))

      assert html =~ "User phone number updated successfully"
      assert html =~ "some updated phone_number"
    end
  end
end
