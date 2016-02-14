module Rack
  module FaradayInspector
    class Middleware
      def initialize(app)
        @app = app
      end

      def config
        Rack::FaradayInspector.config
      end

      def asset_path(*paths)
        ::File.expand_path(::File.join(::File.dirname(__FILE__), '..', '..', '..', 'assets', *paths))
      end

      def compile_css
        path_to_sass = asset_path('sass', 'style.scss')
        @css = Sass::Engine.new(::File.open(path_to_sass).read,
                                cache: true,
                                syntax: :scss,
                                style: :compressed,
                                filename: path_to_sass).render
      end

      def should_compile_css_at_runtime?
        config.development_mode && defined?(Sass)
      end

      def read_compiled_css
        ::File.open(asset_path('css', 'style.css')).read
      end

      def set_javascript
        @javascript = ::File.open(asset_path('javascripts', 'inspector.js')).read
      end

      def set_css
        @css = should_compile_css_at_runtime? ? compile_css : read_compiled_css
      end

      def template
        ::File.open(asset_path('html', 'inspector.html.erb')).read
      end

      def content
        set_css
        set_javascript
        ERB.new(template).result(binding)
      end

      def clear_requests
        Thread.current[:faraday_requests] = nil
      end

      def inject_inspector_into(response)
        new_response = []
        response.each do |body|
          partition = body.rpartition('</body>')
          partition[0] += content.to_s
          new_response << partition.join
        end
        new_response
      end

      def should_inject_inspector?(headers)
        config.enabled && headers['Content-Type'].to_s.include?('text/html')
      end

      def call(env)
        status, headers, response = @app.call(env)

        if should_inject_inspector?(headers)
          response = inject_inspector_into(response)
          headers['Content-Length'] = response.inject(0) do |len, body|
            len + body.bytesize
          end.to_s
        end

        [status, headers, response]
      ensure
        clear_requests
      end
    end
  end
end
