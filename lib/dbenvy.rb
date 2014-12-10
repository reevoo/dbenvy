require "dbenvy/version"
require 'uri'
require 'rack/utils'
require 'yaml'

class DBEnvy
  def self.to_hash
    new.to_hash
  end

  def self.yaml
    new.yaml
  end

  attr_accessor :uri

  def initialize
    self.uri = URI.parse ENV['DATABASE_URL'] if ENV['DATABASE_URL']
  end

  def yaml
    YAML.dump( { rails_env => to_hash } ) if uri && rails_env
  end

  def to_hash
    credentials.merge options
  end

  private

  def rails_env
    ENV['RAILS_ENV']
  end

  def credentials
    {
      "adapter" => uri.scheme,
      "username" => uri.user,
      "password" => uri.password,
      "host" => uri.host,
      "port" => uri.port,
      "database" => database,
    }
  end

  def options
    Rack::Utils.parse_nested_query uri.query
  end

  def database
    uri.path.dup.tap { |p| p.slice!("/") }
  end
end
