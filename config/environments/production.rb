SndTimetracking::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb


  ENV['full_host'] = "https://????.heroku.com"

  #You setup these in Setup > Development > Remote Access
  #Set your callback url to https://localhost:3000/auth/forcedotcom/callback    
ENV['SALESFORCE_KEY'] = "3MVG9yZ.WNe6byQAutDXMv6gpuoJgJRJb0pT7TpcuWAJ9fIQniWMbfayySPOMwpzqGWFj3JI135mXwQEEwDzY"
  ENV['SALESFORCE_SECRET'] = "9136150013852850068"
  ENV['SALESFORCE_SANDBOX_KEY'] = "3MVG9QDx8IX8nP5SyHSF1..8e3XdV9g4LYis5ST_UGWe3wY.MyQtU_KEwFjwTv3kq_HLhoOgIOvCGlOdL0fEW"
  ENV['SALESFORCE_SANDBOX_SECRET'] = "4412083425239725299"
  ENV['SALESFORCE_PRERELEASE_KEY'] = "3MVG9QDx8IX8nP5SyHSF1..8e3W1d0IdqJOw7OhUDeGJKShI6WJWn1K0xQ6bLxSYWQ0y44BttzvpkJ6q9Up8y"
  ENV['SALESFORCE_PRERELEASE_SECRET'] = "1952257251433411827"
  ENV['DATABASE_DOT_COM_KEY'] = "3MVG9QDx8IX8nP5SyHSF1..8e3c3leGiai7e3OqVPPFwgNg5u3voxh1KvUm1PBtQTUGTev.90LlE0nn_rJG6h"
  ENV['DATABASE_DOT_COM_SECRET'] = "730309871727574097"
  ENV['SALESFORCE_CUSTOM_KEY'] = "3MVG9yZ.WNe6byQAutDXMv6gpuoJgJRJb0pT7TpcuWAJ9fIQniWMbfayySPOMwpzqGWFj3JI135mXwQEEwDzY"
  ENV['SALESFORCE_CUSTOM_SECRET'] = "9136150013852850068"

  ENV['DEFAULT_PROVIDER'] = "salesforce"
  #ENV['DEFAULT_PROVIDER'] = "customurl"
  ENV['DEFAULT_CUSTOM_URL'] = "https://medctr--npidev.cs11.my.salesforce.com" #do not add trailing slash
  ENV['app_timeout'] = '1200' #seconds

  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = false

  # Compress JavaScripts and CSS
  config.assets.compress = false

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = true

  # Generate digests for assets URLs
  config.assets.digest = true

  # Defaults to Rails.root.join("public/assets")
  # config.assets.manifest = YOUR_PATH

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = true

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  # config.assets.precompile += %w( search.js )

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify
end
