# TikTakTiokiClient

This is a minimal client implementation for the TikTakTioki server.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add tik_tak_tioki_client

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install tik_tak_tioki_client

## Usage

First: Obtain a game instance

```ruby
# Either: Create a new game
game = TikTakTiokiClient::Game.create!

# Or: Join an existing game
list = TikTakTiokiClient::Game.all_joinables
game = TikTakTiokiClient::Game.join! list.first["name"]
```

Then: Have fun playing the game!

```ruby
# Updating the game
game.update!

# Make a move (game gets updated automatically)
game.make_move(1)

# Note: when an operation fails, it will raise a Faraday exception
# In this example: Making a move when it is the other player's turn
begin
  game.make_move(1)
rescue Faraday::ClientError => e
  puts "Operation failed!"
  puts e.response[:status]
  puts e.response[:body]
end

# Operation failed!
# 422
# {"error":"It's not the players turn"}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fabrik42/tik_tak_tioki_client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/fabrik42/tik_tak_tioki_client/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TikTakTiokiClient project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/fabrik42/tik_tak_tioki_client/blob/master/CODE_OF_CONDUCT.md).
