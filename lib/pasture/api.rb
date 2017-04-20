require 'sinatra/base'
require 'cowsay'
require 'pg'
require 'sequel'

module Pasture

  class API < Sinatra::Base

    include Cowsay

    def initialize
      super()
      puts settings.pasture_options[:db]
      puts 'true' if settings.pasture_options[:db]
      if settings.pasture_options[:db]
      @conn = Sequel.connect(settings.pasture_options[:db])
        unless @conn.table_exists?(:sayings)
          @conn.create_table :sayings do
            primary_key :id
            String :message
          end
        end
      end
    end

    helpers do
      def options
        settings.pasture_options
      end
      def conn
        @conn
      end
    end

    post '/api/v1/cowsay/sayings' do
      halt 501, '501: This endpoint requires a database connection' unless conn
      conn[:sayings].insert(:message => params[:message])
    end

    get '/api/v1/cowsay/sayings' do
      content_type :json
      halt 501, '501: This endpoint requires a database connection' unless conn
      conn[:sayings].all.to_json
    end

    get '/api/v1/cowsay/sayings/:id' do
      content_type :json
      halt 501, '501: This endpoint requires a database connection' unless conn
      message = conn[:sayings].where(:id => params[:id]).naked.first[:message]
      Cowsay.say(message,
                 params[:character] || options[:default_character])
    end

    get '/api/v1/cowsay' do
      content_type :json
      Cowsay.say(params[:message] || options[:default_message] || '',
                 params[:character] || options[:default_character])
    end

  end

end
