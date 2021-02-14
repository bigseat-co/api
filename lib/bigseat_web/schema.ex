defmodule Bigseat.Schema do
  use Absinthe.Schema

  import_types Absinthe.Type.Custom
  import_types Bigseat.Schema.Scalars.Json
  import_types Bigseat.Schema.Scalars.Uuid

  import_types Bigseat.Schema.Dashboard.Types
  import_types Bigseat.Schema.Dashboard.CreateSpace
  import_types Bigseat.Schema.Dashboard.ListSpaces
  import_types Bigseat.Schema.Dashboard.GetSpace
  import_types Bigseat.Schema.Dashboard.Signup
  import_types Bigseat.Schema.Dashboard.Signin
  import_types Bigseat.Schema.Dashboard.AddNewTeamMember

  query do
    import_fields :dashboard_list_spaces
    import_fields :dashboard_get_space
  end

  mutation do
    import_fields :dashboard_signup
    import_fields :dashboard_signin
    import_fields :dashboard_create_space
    import_fields :dashboard_add_new_team_member
  end
end
