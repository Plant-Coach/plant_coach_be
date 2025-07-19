class HealthCheckLoggerFilter
  def initialize(app)
    @app = app
  end

  def call(env)
    # Skip logging for health check endpoints
    if health_check_request?(env['PATH_INFO'])
      Rails.logger.silence { @app.call(env) }
    else
      @app.call(env)
    end
  end

  private

  def health_check_request?(path)
    path == '/rails/health' || path == '/rails/ready'
  end
end
