require 'sinatra'
require 'sinatra/namespace'
require 'sinatra/base'
require 'sequel'
require 'sequel/extensions/seed'
require 'pg'

DB = Sequel.connect(
    adapter: :postgres,
    database: 'sinatra_seq_dev',
    host: 'localhost',
    password: 'password',
    user: 'annie',
    max_connections: 10,
# logger: Logger.new('log/db.log')
)

Sequel::Seed.setup :development # Set the environment
Sequel.extension :seed # Load the extension
Sequel::Seeder.apply(DB, './seeds') # Apply the seeds/fixtures

%w{controllers models routes}.each {|dir| Dir.glob("./#{dir}/*.rb", &method(:require))}



# module MyAppModule
#   class App < Sinatra::Base
#     register Sinatra::Namespace
#
      get '/' do
        'Hello My Sinatrra - Easy and Wide World!'
        redirect to('/hello/World')
      end

      get '/hello/:name' do |n|
        "Sinatra приветствует тебя, #{params[:name]}"
        "Hello #{params['name']}"
        "Hello #{n}!"
      end

      get %r{/hello/([\w]+)} do |c|
        "Hello, #{c}!"
      end

      get '/say/*/to/*' do
        #/say/hello/to/world
        params['splat'].to_s #=> ["hello","world"]
      end

      get '/jobs.?:format?' do
        # "GET/jobs", "GET/jobs.json", "GET/jobs.xml"
        'Маршрут работает'
      end

      namespace '/api/v1' do
        get '/*' do
          "I don't know what is the #{params[:splat]}. It's what you typed"
        end
      end
#   end
# end