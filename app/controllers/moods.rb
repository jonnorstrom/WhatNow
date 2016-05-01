get '/moods' do
  if session[:mood]
    session.delete(:mood)
  end
  erb :moods
end

get "/getflix" do
  if session[:mood]
    movie = Movie.all.where(category: session[:mood].sample).sample
    img_src = params[:imgSrc]
  else
    movie = Movie.all.where(category: params[:genre].sample).sample
    img_src = params[:imgSrc]
    session[:mood] = params[:genre]
  end
  if request.xhr?
    erb :"_movie", :locals => {movie_data: movie, src: img_src}, layout: false
  end
end
