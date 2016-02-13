module Rack
  module FaradayInspector
    class Railtie < Rails::Railtie
      initializer 'rack.faraday_inspector.subscribe' do
        ActiveSupport::Notifications.subscribe('request.faraday.inspector') do |name, starts, ends, _, env|
          Thread.current[:faraday_requests] ||= []
          Thread.current[:faraday_requests] << {
            env: env,
            duration: ends - starts
          }
        end
      end

      initializer "rack.faraday_inspector.inject_middleware" do
        Rails.application.middleware.use Rack::FaradayInspector::Middleware
      end
    end
  end
end
