require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require './models/count.rb'

# set :bind, '192.168.33.10'
set :port, 3000

use Rack::Session::Cookie


before do
  if Count.all.size == 0
    Count.create(number: 0)
  end
end

get '/count' do
  @number = Count.first.number
  erb :index
end

post '/plus' do
  count = Count.first
  if session[:number]
    count.number += session[:number]
  else
    count.number += 1
  end
  count.save
  redirect '/count'
end

post '/one' do
  session[:number] = 1
  redirect '/count'
end
post '/two' do
  session[:number] = 2
  redirect '/count'
end
