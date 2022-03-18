defmodule LiveviewPubsubDemo.Repo.Migrations.CreateUserPhoneNumber do
  use Ecto.Migration

  def change do
    create table(:user_phone_number) do
      add :phone_number, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:user_phone_number, [:user_id])
  end
end
