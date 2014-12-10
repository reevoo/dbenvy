require 'spec_helper'
require 'dbenvy'

describe DBEnvy do
  describe '.to_hash' do
    context 'with a DATABSE_URL in the environment' do

      let(:hash) { described_class.to_hash }

      before do
        ENV['DATABASE_URL'] = 'mysql2://susan:sekret@127.0.0.1:3306/reevoo_live?encoding=utf8&view_options[awesome_database]=awesome_live'
      end

      it 'extracts the adapter' do
        expect(hash['adapter']).to eq 'mysql2'
      end

      it 'extracts the host' do
        expect(hash['host']).to eq '127.0.0.1'
      end

      it 'extracts the database name' do
        expect(hash['database']).to eq 'reevoo_live'
      end

      it 'extracts the username' do
        expect(hash['username']).to eq 'susan'
      end

      it 'extracts the password' do
        expect(hash['password']).to eq 'sekret'
      end

      it 'extracts the port' do
        expect(hash['port']).to eq 3306
      end

      it 'extracts some standard query params' do
        expect(hash['encoding']).to eq 'utf8'
      end
    end
  end

  describe '.yaml' do
    let(:yaml) { described_class.yaml }

    context 'when the DATABASE_URL is not set' do

      before do
        ENV['RAILS_ENV'] = nil
        ENV['DATABASE_URL'] = nil
      end

      it 'is nil' do
        expect(yaml).to be_nil
      end
    end

    context 'when RAILS_ENV is set' do
      before do
        ENV['RAILS_ENV'] = 'production'
        ENV['DATABASE_URL'] = 'mysql2://reevoo:secret@db456.reevoover.com:3306/reevoo_awesome?encoding=utf8&view_options[awesome_database]=awesome_live&socket=%2Fvar%2Frun%2Fmysqld%2Fmysqld.sock'
      end

      it 'uses the current rails env and extracts the database info' do
        expect(YAML.load(yaml)).to eq(
          "production" => {
            "adapter" => "mysql2",
            "username" => "reevoo",
            "port" => 3306,
            "host" => "db456.reevoover.com",
            "database" => "reevoo_awesome",
            "password" => "secret",
            "encoding" => "utf8",
            "socket" => "/var/run/mysqld/mysqld.sock",
            "view_options" => {"awesome_database" => "awesome_live"}})
      end
    end
  end
end

