# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :shout_box,
  ecto_repos: [ShoutBox.Repo]

# Configures the endpoint
config :shout_box, ShoutBox.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EAusdHPetP0ta2lJvz/Ed7HpWen2qR/bvOwlnH4UeulMvqh/vxIxLfq+mxhAfYsw",
  render_errors: [view: ShoutBox.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ShoutBox.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
