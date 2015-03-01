- starting server: `RACK_ENV=development padrino start -p 3001 -a thin`

- Pass environment using `RACK_ENV` environment variable.

- Using environment variables using `dotenv` gem. File name is `.env.<environment>`, for example, .env.development. Added `Dotenv.load ".env.#{Padrino.env}"` to `config/boot.rb` to load it. Aim is to not add these files to git, but for now, let's do it.
- `protect_from_csrf` set to false in `config/apps.rb` to allow post requests and not get 403 forbidden error. Should not do this
- Did not change active record default timezone to `:local` in `config/database.rb`

- To remove milliseconds from timestamp everywhere `ActiveSupport::JSON::Encoding.time_precision = 0` has NOT YET been aded to `config/database.rb`
- Database: `user_profile`


    mysql> show create table users\G
    *************************** 1. row ***************************
    Table: users
    Create Table: CREATE TABLE `users` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
        `phone` varchar(20) NOT NULL,
        `public_name` varchar(50) NOT NULL,
        `first_name` varchar(100) DEFAULT NULL,
        `last_name` varchar(100) DEFAULT NULL,
        `address` varchar(200) DEFAULT NULL,
        `locality` varchar(50) DEFAULT NULL,
        `city` varchar(50) DEFAULT NULL,
        `country` varchar(50) DEFAULT NULL,
        `postal_code` varchar(20) DEFAULT NULL,
        `email` varchar(254) DEFAULT NULL,
        `status` varchar(50) NOT NULL,
        `rating` int(11) unsigned DEFAULT '0',
        `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (`id`),
        UNIQUE KEY `phone` (`phone`),
        KEY `created_at` (`created_at`),
        KEY `updated_at` (`updated_at`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8

    mysql> show create table user_config\G
    *************************** 1. row ***************************
    Table: user_config
      Create Table: CREATE TABLE `user_config` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
        `user_id` int(11) unsigned NOT NULL,
        `phone` varchar(20) NOT NULL,
        `notif_msg` varchar(256) DEFAULT NULL,
        `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (`id`),
        KEY `user_id` (`user_id`),
        KEY `phone` (`phone`),
        KEY `updated_at` (`updated_at`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8
