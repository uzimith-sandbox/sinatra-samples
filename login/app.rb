require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require './models.rb'

set :bind, '192.168.33.10'
set :port, 3000

use Rack::Session::Cookie

get '/' do
  unless session[:user_id]
    redirect "/sign_in"
  end
  erb :index
end

get '/sign_in' do
  erb :sign_in
end

get '/sign_up' do
  erb :sign_up
end

post '/user/create' do
  User.create(
    name: params[:name],
    password: params[:password],
    password_confirmation: params[:password_confirmation]
  )
  redirect "/"
end

post '/session/create' do
  user = User.find_by_name params[:name]
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
  end
  redirect "/"
end
