weather_icons = {
  "clear-day" => ['/imgs/weather/sunny.png', 'happy'],
  "clear-night" => ['/imgs/weather/clear-night.png', 'beers'],
  "rain" => ['/imgs/weather/rain.png', 'sad'],
  "snow" => ['/imgs/weather/snowman2.png', 'inlove'],
  "sleet" => ['/imgs/weather/snow.png', 'shitty'],
  "wind" => ['/imgs/weather/windy.png', 'scary'],
  "fog" => ['/imgs/weather/fog.png', 'spooky'],
  "cloudy" => ['/imgs/weather/cloudy.png', 'thinker'],
  'partly-cloudy-day' => ['/imgs/weather/partly_cloudy.png', 'laughing'],
  'partly-cloudy-night' => ['/imgs/weather/cloud.png', 'wine'],
  'default' => ['/imgs/weather/partly_cloudy.png', 'happy']
}



get '/' do
  if session[:user_id]
    user = User.find(session[:user_id])
    @zip = Zipcode.find_by(zip: user.zip)
    string = "https://api.forecast.io/forecast/e2264a1cad8bbd1362d30c9bab93153d/#{@zip.lat},#{@zip.lng}"
    uri = URI(string)
    response = Net::HTTP.get_response(uri)
    weather = JSON.parse(response.body)
    @src = weather_icons[weather["currently"]["icon"]][0]
    @mood = weather_icons[weather["currently"]["icon"]][1]
    erb :"search_options"
  else
    if session[:errors]
      @error = session[:error]
    end
    erb :login
  end
end
