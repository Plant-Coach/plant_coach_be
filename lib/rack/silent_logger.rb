module Rack
  class SilentLogger
    def initialize(app, options = {})
      @app = app
      @paths = Array(options[:paths] || options[:path])
    end

    def call(env)
      if should_silence?(env['PATH_INFO'])
        Rails.logger.silence { @app.call(env) }
      else
        @app.call(env)
      end
    end

    private

    def should_silence?(path_info)
      @paths.any? { |path| path_info&.start_with?(path) }
    end
  end
end
