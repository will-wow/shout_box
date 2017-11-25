alias ShoutBox.SocialMedia.TwitterMock
alias ShoutBox.SocialMedia.TwitterAuthMock
alias ShoutBox.HTTPoisonMock

alias ShoutBox.SocialMedia.Twitter
alias ShoutBox.SocialMedia.TwitterAuth
alias ShoutBox.HTTPoisonBehavior

ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(ShoutBox.Repo, :manual)

Mox.defmock(TwitterMock, for: Twitter)
Mox.defmock(TwitterAuthMock, for: TwitterAuth)
Mox.defmock(HTTPoisonMock, for: HTTPoisonBehavior)