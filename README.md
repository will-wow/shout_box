# ShoutBox

A simple, testable Phoenix app for a [Carbon Five talk night](https://www.meetup.com/Hack-Night-at-Carbon-Five-LA/events/238967639/)

Note that to run this locally, you'll have to create a `config/dev.secret.exs` with the contents:

```elixir
use Mix.Config

config :shout_box, ShoutBox.SocialMedia.TwitterAuth,
  consumer_secret: "TWITTER_CONSUMER_SECRET_HERE",
  consumer_key: "TWITTER_CONSUMER_KEY_HERE"
```
To get the twitter picture integration running, you'll need to create a Twitter Apps application here `https://apps.twitter.com/`.
You can make the application's Access Level "Read-only". Then, copt the Consumer Key and Consumer Secret into your
`dev.secret.exs` file. This file won't be commited to version control, to keep your keys safe.

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

To run the tests:
  * Run all unit tests with `mix test`
  * To run a single test with `mix test test/shout_box/path/to/test:15`

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
