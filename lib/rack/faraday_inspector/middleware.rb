module Rack
  module FaradayInspector
    class Middleware
      def initialize(app)
        @app = app
      end

      def template_path(*paths)
        ::File.expand_path(::File.join(::File.dirname(__FILE__), '..', '..', *paths))
      end

      def css_template_path
        template_path('sass', 'styles.scss')
      end

      def css_template
        ::File.open(css_template_path).read
      end

      def render_css
        @css = Sass::Engine.new(css_template,{
          cache: true,
          syntax: :scss,
          style: :compressed,
          filename: css_template_path,
        }).render
      end

      def template
        ::File.open(template_path('html', 'inspector.html.erb')).read
      end

      def content
        render_css
        ERB.new(template).result(binding)
      end

      def clear_requests
        Thread.current[:faraday_requests] = nil
      end

      def call(env)
        status, headers, response = @app.call(env)

        if headers['Content-Type'].to_s.include? 'text/html'
          new_response = []
          response.each do |body|
            partition = body.rpartition('</body>')
            partition[0] += content.to_s
            new_response << partition.join
          end

          # Update the content-length
          headers['Content-Length'] = new_response.inject(0) do |len, body|
            len += body.bytesize
          end.to_s

          [status, headers, new_response]
        else
          [status, headers, response]
        end
      ensure
        clear_requests
      end
    end
  end
end
