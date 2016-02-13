require 'faraday_middleware/instrumentation'

module Faraday
  class Inspector < FaradayMiddleware::Instrumentation
    def initialize(app, options = {})
      super(app)
      @name = options.fetch(:name, 'request.faraday.inspector')
    end
  end
end

Faraday::Middleware.register_middleware inspector: -> { Faraday::Inspector }
