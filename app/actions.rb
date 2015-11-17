# Homepage (Root path)

# binding.pry
get '/' do
  # binding.pry
  erb :index
end
get '/tracks' do
  @tracks = Track.all
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
