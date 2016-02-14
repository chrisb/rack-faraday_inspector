require 'faraday/inspector'
require 'rack/faraday_inspector/version'
require 'rack/faraday_inspector/asset_version'
require 'rack/faraday_inspector/middleware'
require 'active_support/configurable'

if defined?(::Rails) && ::Rails::VERSION::MAJOR.to_i >= 3
  require 'rack/faraday_inspector/railtie'
end

module Rack
  module FaradayInspector
    include ActiveSupport::Configurable

    config.development_mode = false
    config.enabled = false
    config_accessor :enabled
  end
end
