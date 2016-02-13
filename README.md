# Rack::FaradayInspector

Rack::FaradayInspector renders a bit of HTML at the bottom of your pages that allows you to inspect all of the requests Faraday made for the current request.

![rack-faraday_inspector](https://cloud.githubusercontent.com/assets/29424/13030496/029e5f7a-d262-11e5-886c-1b8e3b8a6260.gif)

Currently only supports Rails. Requires SASS and jQuery.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-faraday_inspector', group: :development
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-faraday_inspector

## Usage

To view requests, simply add the middleware to each of the Faraday connections you want to inspect:

```ruby
require 'rack/faraday_inspector'

Faraday.new url: 'http://www.sushi.com' do |faraday|
  faraday.use :inspector
  # ...
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/chrisb/rack-faraday_inspector.
