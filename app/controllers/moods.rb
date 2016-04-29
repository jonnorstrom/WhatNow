get '/moods' do
  erb :moods
end




get "/getflix" do
  key = params.keys[0]
  value = params[key].split(" ").join("%20")
  string = "http://netflixroulette.net/api/api.php" + "?#{key}=#{value}"
  uri = URI(string)
  response = Net::HTTP.get_response(uri)
  stuff = JSON.parse(response.body)[0]
  p stuff
  if request.xhr?
    erb :"_movie", :locals => {movie_data: stuff}, layout: false
  end
end
