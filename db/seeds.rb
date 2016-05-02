### to use this seed file, take awat the method naming lines and their corresponding 'end's, then run DB:seed
## Once you have the movies you want, comment out the first method and uncomment the write_csv method and run DB:seed again


 def gather_movies
    movies = Movie.all
    more_movies = movies.reverse

    more_movies.each do |film|
      actors = film.cast.split(", ")
      actors.each do |person|
        value = person.split(" ").join("%20")
        string = "http://netflixroulette.net/api/api.php?actor=" + "#{value}"
        uri = URI(string)
        response = Net::HTTP.get_response(uri)
        movies = JSON.parse(response.body)
        movies.each do |movie_data|
          if movie_data[0] == "errorcode"
            nil
          else
            Movie.find_or_create_by(
                  title: movie_data["show_title"],
                  year: movie_data["release_year"],
                  rating: movie_data["rating"],
                  category: movie_data["category"],
                  cast: movie_data["show_cast"],
                  director: movie_data["director"],
                  summary: movie_data["summary"],
                  poster: movie_data["poster"]
                )
        end # if end
      end # movies.each end
    end # actors.each end
  end # more_movies.each end
end# def gather_movies end

# def write_csv
#   CSV.open("./ALL_MOVIES.csv", "wb") do |csv|
#     csv << Movie.attribute_names
#     Movie.all.each do |movie|
#       csv << movie.attributes.values
#     end # csv end
#   end # Movie.each end
# end# write_csv end
