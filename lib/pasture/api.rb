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

    get '/' do
      Cowsay.say(params[:string] || "", params[:character] || options['character'])
    end

  end

end
