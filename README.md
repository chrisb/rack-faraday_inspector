# Rack::FaradayInspector

Rack::FaradayInspector renders a bit of HTML at the bottom of your pages that allows you to inspect all of the HTTP requests Faraday made during the current Rails action.

It's like your browser's developer tools network view, but for your backend API requests.

![rack-faraday_inspector](https://cloud.githubusercontent.com/assets/29424/13030496/029e5f7a-d262-11e5-886c-1b8e3b8a6260.gif)

Currently only supports Rails and requires jQuery.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-faraday_inspector', github: 'chrisb/rack-faraday_inspector'
```

I'm still actively working on this Gem, so pull from GitHub.

## Usage

In order to instrument and show Faraday requests, you'll need to add the middleware to your connection:

```ruby
Faraday.new url: 'http://www.sushi.com' do |faraday|
  faraday.use :inspector
  # ...
end
```

By default the inspector web UI is disabled. To enable the inspector, add the following to an initializer, or better yet, to the specific Rails environment configurations that you want to enable the inspector for:

i.e. in `config/environments/development.rb`:

```ruby
Rails.application.configure do
  # ...
  Rack::FaradayInspector.enabled = true
end
```

Or in something like `config/initializers/faraday_inspector.rb`:

```ruby
Rack::FaradayInspector.enabled = Rails.env.development?
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/chrisb/rack-faraday_inspector.
