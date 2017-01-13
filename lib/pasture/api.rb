require 'sinatra/base'
require 'cowsay'

module Pasture

  class API < Sinatra::Base

    include Cowsay

    helpers do
      def options
        settings.pasture_options
      end
    end

    get '/api/v1/cowsay' do
      Cowsay.say(params[:message] || options[:default_message] || '',
                 params[:character] || options[:default_character])
    end

  end

end
