class Comments
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :comment, String
  property :created_at, DateTime
end


DataMapper.finalize
DataMapper.auto_migrate!
DataMapper.auto_upgrade!


get '/comments' do
  @comments_obj = Comments.all
  erb :comments
end


get '/comments/new' do
  @current_time = Time.now
  erb :comments_new
end

#create one new student info
post '/comments/new' do

  cm = Comments.create params[:comment]
  redirect to ("/comments/#{cm.id}")
end

get '/comments/:id' do
  @comment_obj = Comments.get(params[:id])
  erb :comments_show
end

