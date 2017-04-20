require 'sinatra/base'
require 'cowsay'
require 'pg'
require 'sequel'

module Pasture

  class API < Sinatra::Base

    include Cowsay

    def initialize
      super()
      @conn = settings.pasture_options[:db] ? Sequel.connect(settings.pasture_options[:db]) : Sequel.sqlite
      unless @conn.table_exists?(:sayings)
        @conn.create_table :sayings do
          primary_key :id
          String :message
        end
      end
    end

    helpers do
      def options
        settings.pasture_options
      end
      def conn
        @conn ||= Sequel.connect(settings.pasture_options[:db])
      end
    end

    post '/api/v1/cowsay/sayings' do
      conn[:sayings].insert(:message => params[:message])
    end

    get '/api/v1/cowsay/sayings' do
      content_type :json
      conn[:sayings].all.to_json
    end

    get '/api/v1/cowsay/sayings/:id' do
      content_type :json
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
