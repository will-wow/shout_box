use Mix.Config

config :shout_box, :http, ShoutBox.Test.Mocks.HTTPoison
config :shout_box, :twitter_auth, ShoutBox.Test.Mocks.TwitterAuth
config :shout_box, :twitter, ShoutBox.Test.Mocks.Twitter
