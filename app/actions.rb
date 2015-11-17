# Homepage (Root path)

# binding.pry
get '/' do
  # binding.pry
  erb :index
end
get '/tracks' do
  @tracks = Track.all

  @message = params[:message]

  # binding.pry
  erb :'tracks/index'
end
get '/tracks/new' do
  # binding.pry
  erb :'tracks/new'
end
post '/tracks' do
  # binding.pry
  # key of hash is form's input name
  @track = Track.new(
    song_title: params[:song_title],
    author:     params[:author],
    url:        params[:url]
  )
  @track.save
  # binding.pry
  redirect '/tracks'
end
post '/votes' do
  @vote = Vote.create(track_id: params[:track_id].to_i, user_id: params[:user_id].to_i)
  if @vote.persisted?
    redirect '/tracks'
  else
    redirect '/tracks?message=Cannot vote for track twice'
  end
end

post '/login' do
  # get the user's email
  # get the user's password
   user = User.find_by(email: params[:email], password: params[:password])
   if user
     # Remember that this user logged in  (see below)
     session[:user_id] = user.id
     redirect '/tracks'
   else
     redirect '/tracks?message=Invalid email and password'
   end

  # if params[:email] == "monica@gmail.com" && params[:password] == "test"
  #   session[:user_id] = 1
  #   redirect '/tracks'
  # else
  #   redirect '/tracks?message=Invalid email and password'
  # end
end

post '/logout' do
  # reset the entire session
  session[:user_id] = nil
  session.clear

  redirect '/tracks'
end
# HINT: Logout
# session.clear
# session[:user_id] = nil
