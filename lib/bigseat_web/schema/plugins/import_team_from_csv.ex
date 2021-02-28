defmodule Bigseat.Schema.Plugins.ImportTeamFromCsv do
  use Absinthe.Schema.Notation
  alias Crudry.Middlewares.TranslateErrors

  object :plugins_import_team_from_csv do
    @desc "Import team members from CSV"
    field :import_team_from_csv, list_of(:gateway_space) do
      arg :file, non_null(:upload)

      middleware BigseatWeb.Middleware.AuthorizedAdmin
      resolve &resolve/3
      middleware TranslateErrors
    end
  end

  def resolve(_parent, %{ file: file }, _resolution) do
    require IEx; IEx.pry
  end

  def resolve(_parent, _args, _resolution) do
    {:error, "not found"}
  end
end
