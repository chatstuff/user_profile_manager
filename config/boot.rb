# Defines our constants
RACK_ENV = ENV['RACK_ENV'] ||= 'development'  unless defined?(RACK_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

# Load our dependencies
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, RACK_ENV)
Dotenv.load ".env.#{Padrino.env}"

##
# ## Enable devel logging
#
# Padrino::Logger::Config[:development][:log_level]  = :devel
# Padrino::Logger::Config[:development][:log_static] = true
#
# ## Configure your I18n
#
# I18n.default_locale = :en
# I18n.enforce_available_locales = false
#
# ## Configure your HTML5 data helpers
#
# Padrino::Helpers::TagHelpers::DATA_ATTRIBUTES.push(:dialog)
# text_field :foo, :dialog => true
# Generates: <input type="text" data-dialog="true" name="foo" />
#
# ## Add helpers to mailer
#
# Mail::Message.class_eval do
#   include Padrino::Helpers::NumberHelpers
#   include Padrino::Helpers::TranslationHelpers
# end

# [:log_level] = {:fatal => 7,:error => 6,:warn => 4,:info  => 3,:debug => 0,:devel => -1}
# [:stream] = :stdout # [:to_file, :null, :stdout, :stderr]
# [:format_message] = '”%s - - [%s] "%s"“'
# [:log_static] = false (Default)
logger = File.open('/var/log/user-profile.log', "a+")
Padrino::Logger::Config.merge!({
  # still have to figure out how to change file path
    :development => {:log_level => :devel, :stream => logger, :format_datetime => " [%Y-%m-%d %H:%M:%S] ", :colorize_logging => true},
    :test => {:log_level => :debug, :stream => logger, :format_datetime => " [%Y-%m-%d %H:%M:%S] ", :colorize_logging => false},
    :staging => {:log_level => :debug, :stream => logger, :format_datetime => " [%Y-%m-%d %H:%M:%S] ", :colorize_logging => false},
    :production => {:log_level => :debug, :stream => logger, :format_datetime => " [%Y-%m-%d %H:%M:%S] ", :colorize_logging => false}
})

##
# Add your before (RE)load hooks here
#
Padrino.before_load do
end

##
# Add your after (RE)load hooks here
#
Padrino.after_load do
end

Padrino.load!
