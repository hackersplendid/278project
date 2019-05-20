require 'dm-core'
require 'dm-migrations'
#require 'data_mapper'


#define the model
class Students
  include DataMapper::Resource
  property :id, Serial
  property :firstname, String
  property :lastname, String
  property :birthday, Date
  property :address, String
  property :student_id, Integer
end

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/students.db")

DataMapper.finalize
DataMapper.auto_migrate!
DataMapper.auto_upgrade!

#show all students' short info and link to profile
get '/students' do
  if session[:admin]
    @students_obj = Students.all
    erb :students
  else
    erb :login
  end
end


get '/students/new' do
  erb :student_new
end

#create one new student info
post '/students/new' do
  st = Students.create params[:student]

  redirect to ("/students/#{st.id}")
end

#edit student info
get '/students/:id/edit' do
  @student_obj = Students.get(params[:id])
  erb :student_edit
end


#show one student's profile
get '/students/:id' do
  @student_obj = Students.get(params[:id])
  erb :student_show
end



#delete student info and redirect to
get '/students/:id/delete' do
  Students.get(params[:id]).destroy
  redirect to ('/students')
end



post '/students/:id/edit' do
  student = Students.get(params[:id])
  student.update(params[:student])
  redirect to ("/students/#{student.id}")

end