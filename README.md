[![Build Status](https://travis-ci.org/reevoo/dbenvy.svg?branch=master)](https://travis-ci.org/reevoo/dbenvy)

# DBEnvy

Load DB info from the environment

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dbenvy'
```

And then execute:

    $ bundle

## Usage

Add the following to your database.yml file and set the DATABASE_URL environment variable.

```
<%= DBEnvy.yaml %>
```

## Note

You do not need this in a Rails 4.1 app as loading database info from DATABASE_URL is supported out of the box

## Contributing

1. Fork it ( https://github.com/reevoo/dbenvy/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
