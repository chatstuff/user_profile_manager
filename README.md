- starting server: `RACK_ENV=development padrino start -p 3001 -a thin`

- Pass environment using `RACK_ENV` environment variable.

- Using environment variables using `dotenv` gem. File name is `.env.<environment>`, for example, .env.development. Added `Dotenv.load ".env.#{Padrino.env}"` to `config/boot.rb` to load it. Aim is to not add these files to git, but for now, let's do it.
- `protect_from_csrf` set to false in `config/apps.rb` to allow post requests and not get 403 forbidden error. Should not do this
- Did not change active record default timezone to `:local` in `config/database.rb`

- To remove milliseconds from timestamp everywhere `ActiveSupport::JSON::Encoding.time_precision = 0` has NOT YET been aded to `config/database.rb`
