defmodule Bigseat.Repo.Migrations.SpaceOpenHour do
  use Ecto.Migration

  def change do
    create table(:space_open_hours, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :day_of_the_week, :string
      add :open_time, :time
      add :close_time, :time
      add :space_id, references(:spaces, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:space_open_hours, [:space_id])
  end
end
