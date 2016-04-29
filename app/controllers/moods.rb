# get '/really/dont/go/here/again' do
#   require 'csv'
#   movies = Movie.all
#   more_movies = movies.shuffle
#
#   more_movies.each do |film|
#     actors = film.cast.split(", ")
#     actors.each do |person|
#       value = person.split(" ").join("%20")
#       string = "http://netflixroulette.net/api/api.php?actor=" + "#{value}"
#       uri = URI(string)
#       response = Net::HTTP.get_response(uri)
#       movies = JSON.parse(response.body)
#       movies.each do |movie_data|
#         if movie_data[0] == "errorcode"
#           nil
#         else
#           Movie.find_or_create_by(
#                 title: movie_data["show_title"],
#                 year: movie_data["release_year"],
#                 rating: movie_data["rating"],
#                 category: movie_data["category"],
#                 cast: movie_data["show_cast"],
#                 director: movie_data["director"],
#                 summary: movie_data["summary"],
#                 poster: movie_data["poster"]
#               )
#         end
#       end
#     end
#     CSV.open("./ALL_MOVIES.csv", "wb") do |csv|
#       csv << Movie.attribute_names
#       Movie.all.each do |movie|
#         csv << movie.attributes.values
#       end
#     end
#   end
# end

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
