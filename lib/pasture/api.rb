require 'sinatra/base'
require 'cowsay'

module Pasture

  class API < Sinatra::Base

    include Cowsay

    get '/' do
      Cowsay.say("test", nil)
    end

  end

end
