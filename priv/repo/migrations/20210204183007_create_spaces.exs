defmodule Bigseat.Repo.Migrations.CreateSpaces do
  use Ecto.Migration

  def change do
    create table(:spaces, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :slug, :string
      add :name, :string
      add :avatar_url, :string
      add :organization_id, references(:organizations, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:spaces, [:organization_id])
    create unique_index(:spaces, [:organization_id, :slug])
  end
end
