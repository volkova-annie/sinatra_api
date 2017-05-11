require 'sinatra'
require 'sinatra/namespace'
require 'sinatra/base'

module MyAppModule
  class App < Sinatra::Base
    register Sinatra::Namespace

      get '/' do
        # 'Hello My Sinatrra - Easy and Wide World!'
        redirect to('/hello/World')
      end

      get '/hello/:name' do |n|
        # "Sinatra приветствует тебя, #{params[:name]}"
        # "Hello #{params['name']}"
        "Hello #{n}!"
      end

      get %r{/hello/([\w]+)} do |c|
        "Hello, #{c}!"
      end

      namespace '/api/v1' do
        get '/*' do
          "I don't know what is the #{params[:splat]}. It's what you typed"
        end
      end
  end
end