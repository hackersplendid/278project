require 'sinatra'
require './students'
require './comments'

configure do
  enable :sessions
  set username: "yirui"
  set password: "COEN278"
end

configure :development do
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/students.db")
end

configure :production do
  require 'data_mapper'
  DataMapper.setup(:default, ENV['DATABASE_URL'])
end


get '/login' do
  erb :login
end

get '/logout' do
  session.clear
  redirect to ('/login')
end

post '/login' do
  if params[:username] == settings.username && params[:password] == settings.password
    session[:admin] = true
    redirect to('/')
  else
    erb :login
  end
end

get '/' do
  @title = "home"
  erb :home
end

get '/about' do
  #@name = :view
  @title = "about"
  erb :about
end

get '/contact' do
  @title = "contact"
  erb :contact
end

get '/video' do
  erb :video
end

get '/*' do
  @route = params[:splat]
  pass
end

not_found do
  erb :notfound, :layout=>false
end

