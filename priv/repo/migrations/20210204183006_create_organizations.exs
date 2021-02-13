defmodule Bigseat.Repo.Migrations.CreateOrganizations do
  use Ecto.Migration

  def change do
    create table(:organizations, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :slug, :string
      add :name, :string

      timestamps()
    end

    create unique_index(:organizations, [:slug])
  end
end
