use Mix.Config

config :shout_box, :http, ShoutBox.HTTPoisonMock
config :shout_box, :twitter_auth, ShoutBox.SocialMedia.TwitterAuthMock
config :shout_box, :twitter, ShoutBox.SocialMedia.TwitterMock
