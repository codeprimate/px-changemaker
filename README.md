# Pxapp4

## Development

To start your new Phoenix application:

1. Install dependencies with `mix deps.get`
2. Start Phoenix endpoint with `mix phoenix.server`

Now you can visit `localhost:4000` from your browser.

## Production

1. Install dependencies/compile with `mix do deps.get, compile, compile.protocols`
2. Start Phoenix endpoint with `MIX_ENV=prod PORT=4001 elixir -pa _build/prod/consolidated -S mix phoenix.server`

Now you can visit `localhost:4001` from your browser.

# Heroku

* Uses buildpack: https://github.com/HashNuke/heroku-buildpack-elixir
* App is at: https://px-changemaker.herokuapp.com/


