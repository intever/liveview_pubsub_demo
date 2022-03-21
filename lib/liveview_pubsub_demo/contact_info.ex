defmodule LiveviewPubsubDemo.ContactInfo do
  @moduledoc """
  The ContactInfo context.
  """

  import Ecto.Query, warn: false
  alias LiveviewPubsubDemo.Repo
  alias Ecto.Multi

  alias LiveviewPubsubDemo.ContactInfo.UserPhoneNumber
  alias LiveviewPubsubDemo.Events

  @doc """
  Returns the list of user_phone_number.

  ## Examples

      iex> list_user_phone_number()
      [%UserPhoneNumber{}, ...]

  """
  def list_user_phone_number do
    Repo.all(UserPhoneNumber)
  end

  @doc """
  Gets a single user_phone_number.

  Raises `Ecto.NoResultsError` if the User phone number does not exist.

  ## Examples

      iex> get_user_phone_number!(123)
      %UserPhoneNumber{}

      iex> get_user_phone_number!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_phone_number!(id), do: Repo.get!(UserPhoneNumber, id)

  @doc """
  Creates a user_phone_number.

  ## Examples

      iex> create_user_phone_number(%{field: value})
      {:ok, %UserPhoneNumber{}}

      iex> create_user_phone_number(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_phone_number(%UserPhoneNumber{} = user_phone_number, attrs \\ %{}) do
    user_phone_number
    |> UserPhoneNumber.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_phone_number.

  ## Examples

      iex> update_user_phone_number(user_phone_number, %{field: new_value})
      {:ok, %UserPhoneNumber{}}

      iex> update_user_phone_number(user_phone_number, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_phone_number(%UserPhoneNumber{} = user_phone_number, attrs) do
    result =
      Multi.new()
      |> multi_update_user_phone_number(:user_phone_number, user_phone_number, attrs)
      |> Repo.broadcast_transaction()

    case result do
      {:ok, %{user_phone_number: user_phone_number}} ->
        {:ok, user_phone_number}

      {:error, :user_phone_number, changeset, _changes} ->
        {:error, changeset}
    end
  end

  def multi_update_user_phone_number(
        multi,
        id,
        %UserPhoneNumber{} = user_phone_number,
        attrs \\ %{}
      ) do
    changeset = UserPhoneNumber.changeset(user_phone_number, attrs)

    multi
    |> Multi.update(id, changeset)
    |> Multi.merge(fn changes ->
      user_phone_number = changes[id]

      Events.multi_create_user_event(
        Multi.new(),
        id,
        %{
          type: "user_phone_number.updated",
          user_id: user_phone_number.user_id,
          event_at: user_phone_number.updated_at,
          data: Map.take(user_phone_number, [:id, :user_id, :phone_number])
        },
        [
          "user-phone-number.updated.*",
          "user-phone-number.updated.id:#{user_phone_number.id}",
          "user-phone-number.updated.user-id:#{user_phone_number.user_id}",
          "user-phone-number.*.id:#{user_phone_number.id}",
          "user-phone-number.*.user-id:#{user_phone_number.user_id}",
          "user-phone-number.*.*"
        ]
      )
    end)
  end

  @doc """
  Deletes a user_phone_number.

  ## Examples

      iex> delete_user_phone_number(user_phone_number)
      {:ok, %UserPhoneNumber{}}

      iex> delete_user_phone_number(user_phone_number)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_phone_number(%UserPhoneNumber{} = user_phone_number) do
    Repo.delete(user_phone_number)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_phone_number changes.

  ## Examples

      iex> change_user_phone_number(user_phone_number)
      %Ecto.Changeset{data: %UserPhoneNumber{}}

  """
  def change_user_phone_number(%UserPhoneNumber{} = user_phone_number, attrs \\ %{}) do
    UserPhoneNumber.changeset(user_phone_number, attrs)
  end
end
