# Require and add custom middleware to filter health check logs
require_relative '../../lib/rack/health_check_logger_filter'
Rails.application.config.middleware.insert_before Rails::Rack::Logger, HealthCheckLoggerFilter
