weather_icons = {
  "clear-day" => '/imgs/weather/sunny.png',
  "clear-night" => '/imgs/weather/clear-night.png',
  "rain" => '/imgs/weather/rain.png',
  "snow" => '/imgs/weather/snowman2.png',
  "sleet" => '/imgs/weather/snow.png',
  "wind" => '/imgs/weather/windy.png',
  "fog" => '/imgs/weather/fog.png',
  "cloudy" => '/imgs/weather/cloudy.png',
  'partly-cloudy-day' => '/imgs/weather/partly_cloudy.png',
  'partly-cloudy-night' => '/imgs/weather/cloud.png',
  'default' => '/imgs/weather/partly_cloudy.png'
};



get '/' do
  if session[:user_id]
    user = User.find(session[:user_id])
    @zip = Zipcode.find_by(zip: user.zip)
    string = "https://api.forecast.io/forecast/e2264a1cad8bbd1362d30c9bab93153d/#{@zip.lat},#{@zip.lng}"
    uri = URI(string)
    response = Net::HTTP.get_response(uri)
    weather = JSON.parse(response.body)
    @src = weather_icons[weather["currently"]["icon"]]
    erb :"search_options"
  else
    if session[:errors]
      @error = session[:error]
    end
    erb :login
  end
end
