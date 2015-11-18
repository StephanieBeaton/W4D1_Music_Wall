# Homepage (Root path)

get '/' do
  @message = params[:message]

  if session[:user_id]
    redirect '/tracks'
  else
    erb :index
  end
end
get '/tracks' do
  @tracks = Track.all

  @tracks_temp = Track.joins('LEFT JOIN votes ON votes.track_id = tracks.id')
                      .where('votes.id is not null or votes.id is null')

  @tracks_temp_grouped = @tracks_temp.group('tracks.id')
  @tracks_temp_count =   @tracks_temp_grouped.count('votes.id')

  # results
  # {1=>3, 2=>2, 3=>1, 4=>1, 5=>1, 6=>1, 7=>1, 8=>1, 9=>2}
  @tracks_temp_sorted = @tracks_temp_count.sort_by{|k,v| -v}

  @tracks = @tracks_temp_sorted.map  do | an_array |
     Track.find(an_array[0])
  end

  # binding.pry

  @message = params[:message]

  erb :'tracks/index'
end
get '/tracks/new' do
  erb :'tracks/new'
end
#  this would be more understandable is  post /newtracks ??
post '/tracks' do
  # key of hash is form's input name
  @track = Track.new(
    song_title: params[:song_title],
    author:     params[:author],
    url:        params[:url]
  )
  @track.saveei
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
  #
  # Davids code
  #
  # store the username they typed to show in the field in the form if their password was incorrect
  # session['username_given'] = params['username']
  # userpass = DATABASE[params['username']]
  # if userpass && BCrypt::Password.new(userpass) == params['password']
  #   session['username'] = params['username']
  # end
  # redirect '/'

  session['user_email'] = params['email']

  # ==============================================

  @user = User.find_by_email(params[:email])
  #binding.pry

  temp = BCrypt::Password.new(@user.password)

  #binding.pry
  temp_user_entered_password = params[:password]

  #binding.pry

  if BCrypt::Password.new(@user.password) == params[:password]
    # Remember that this user logged in  (see below)
    #binding.pry
    session[:user_id] = @user.id
    redirect '/tracks'
  else
    redirect '/?message=Invalid email and password'
  end

  # =============================================


  # get the user's password
  # user = User.where('email = ?', params[:email])

  # params[:password] == BCrypt::Password.new(user.password)

  # binding.pry
  # if (user && user.password == reencrypted_password)
  # OLD    user = User.find_by(email: params[:email], password: params[:password])
  # OLD if user

   # Remember that this user logged in  (see below)
  #  session[:user_id] = user.id
  #  redirect '/tracks'
  # else
  #  redirect '/tracks?message=Invalid email and password'
  # end
end

get '/logout' do
  # reset the entire session
  session[:user_id] = nil
  session.clear

  redirect '/'
end

get '/users/new' do

  erb :'users/new'
  # erb :'tracks/new'

end

post '/users' do

  # include BCrypt
  # save to database, bcrypt password before saving

  password = params[:password]

  encrypted_password = BCrypt::Password.create(password)

  user = User.create(email: params[:email], password: encrypted_password)

  if user
    session[:user_id] = user.id
    redirect '/tracks'
  else
    redirect '/users/new?message=Account creation failed'
  end
end
