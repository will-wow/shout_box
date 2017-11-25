alias ShoutBox.SocialMedia.TwitterMock
alias ShoutBox.SocialMedia.TwitterAuthMock
alias ShoutBox.HTTPoisonMock

alias ShoutBox.SocialMedia.Twitter
alias ShoutBox.SocialMedia.TwitterAuth
alias ShoutBox.HTTPoisonBehavior

Mox.defmock(TwitterMock, for: Twitter)
Mox.defmock(TwitterAuthMock, for: TwitterAuth)
Mox.defmock(HTTPoisonMock, for: HTTPoisonBehavior)