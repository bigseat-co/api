defmodule Bigseat.Organization.Spaces do
  import Ecto.Query, warn: false
  alias Bigseat.Repo
  alias Bigseat.Core.Space

  def list(organization_id) do
    query = from space in Space,
            where: space.organization_id == ^organization_id,
            preload: [:open_hours]

    Repo.all(query)
  end
end
