defmodule LiveviewPubsubDemo.ContactInfo do
  @moduledoc """
  The ContactInfo context.
  """

  import Ecto.Query, warn: false
  alias LiveviewPubsubDemo.Repo

  alias LiveviewPubsubDemo.ContactInfo.UserPhoneNumber

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
    user_phone_number
    |> UserPhoneNumber.changeset(attrs)
    |> Repo.update()
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
