defmodule Bigseat.Repo.Migrations.CreateIdentities do
  use Ecto.Migration

  def change do
    create table(:identities, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :string
      add :encrypted_password, :string
      add :first_name, :string
      add :last_name, :string
      add :is_admin, :boolean, default: false, null: false
      add :group, :string
      add :organization_id, references(:organizations, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:identities, [:organization_id])
    create unique_index(:identities, [:organization_id, :email])
  end
end
