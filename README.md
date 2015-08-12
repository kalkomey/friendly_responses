# friendly-responses

Provides friendly responses for validation and server errors to RESTful Rails JSON APIs.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'friendly-responses'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install friendly-responses

## Usage

Simply include the `FriendlyResponses` module in your controller to enable friendly-responses.
You may prefer to include this module in your application controller
or a controller your API controllers will subclass as shown in the example below.

```
# app/controllers/api_controller.rb
class ApiController < ApplicationController
  include FriendlyResponses
  # ...custom controller code
end
```

## Validation errors

The friendly-responses gem provides a convenient way to respond with validation errors
that are actually useful to API clients. In the example controller action below, we
call the `#respond_with_invalid_record` method with our model to create a friendly
error response.

```
# app/controller/frienemies_controller.rb
class FrienemiesController < ApiController
  def create
    @frienemy = Frienemy.new frienemy_params

    if @frienemy.save
      render action: 'show', status: :created
    else
      respond_with_invalid_record @frienemy
    end
  end
end
```

Here is an example of a request that triggers a validation error and a friendly response.

```
$ curl -i -X POST http://localhost:3000/frienemies \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '{ "frienemy": { "name": "Donald Trump" } }'

{
  "errors": [
    "Why you can't have a frienemy for no reason"
  ],
  "frienemy": {
    "errors": {
      "why": [
        "you can't have a frienemy for no reason"
      ]
    }
  }
}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kalkomey/friendly-responses.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

