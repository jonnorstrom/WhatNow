weather_icons = {
  "clear-day" => ['/imgs/weather/sunny.png', 'happy'],
  "clear-night" => ['/imgs/weather/clear-night.png', 'beers'],
  "rain" => ['/imgs/weather/rain.png', 'sad'],
  "snow" => ['/imgs/weather/snowman2.png', 'inlove'],
  "sleet" => ['/imgs/weather/snow.png', 'shitty'],
  "wind" => ['/imgs/weather/windy.png', 'scary'],
  "fog" => ['/imgs/weather/fog.png', 'spooky'],
  "cloudy" => ['/imgs/weather/cloudy.png', 'thinker'],
  'partly-cloudy-day' => ['/imgs/weather/partly_cloudy.png', 'happy'],
  'partly-cloudy-night' => ['/imgs/weather/cloud.png', 'thinker'],
  'default' => ['/imgs/weather/partly_cloudy.png', 'happy']
}

get '/' do
  if session[:mood]
    session.delete(:mood)
  end
  if session[:user_id]
    user = User.find(session[:user_id])
    @zip = user.find_coords
    string = "https://api.forecast.io/forecast/e2264a1cad8bbd1362d30c9bab93153d/#{@zip[:lat]},#{@zip[:lng]}"
    uri = URI(string)
    begin
      weather_info = Timeout::timeout(5) {
        response = Net::HTTP.get_response(uri)
        weather_response = JSON.parse(response.body)
        weather_response["currently"]["icon"]
      }
    rescue Timeout::Error
      weather_info = "default"
    end
    @src = weather_icons[weather_info][0]
    @mood = weather_icons[weather_info][1]
    erb :"search_options"
  else
    redirect '/login'
  end
end

get '/search' do
  erb :search
end
