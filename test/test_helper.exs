{:ok, _} = Application.ensure_all_started(:ex_machina)
ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Bigseat.Repo, :manual)
Absinthe.Test.prime(Bigseat.Schema)
