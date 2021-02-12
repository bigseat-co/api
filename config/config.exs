# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bigseat,
  ecto_repos: [Bigseat.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :bigseat, BigseatWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "g8kbEu7vBkYWF1fCHpDHL6fFKOp7h5rBdofICvENrxEVbr/RXQo7Z/ws4FAx+zMa",
  render_errors: [view: BigseatWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Bigseat.PubSub,
  live_view: [signing_salt: "F/wV2zPz"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :bigseat, Bigseat.Guardian,
  issuer: "bigseat",
  secret_key: "JX+5SOTn52STCCbu7fjvTp+Q0ex9Klsf+8OEzdEzaIQArh/48o94hXfHjihpHirC"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
