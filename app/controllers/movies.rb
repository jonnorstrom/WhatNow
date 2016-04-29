get '/movies/:genre' do
  genre = params[:genre]
  movie_data = Movie.all.where(category: genre).sample

  erb :"_movie", :locals => {movie_data: movie_data, src: '/imgs/search1.png'}
end
