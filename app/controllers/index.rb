get '/' do
  if session[:user_id]
    erb :"search_options"
  else
    if session[:errors]
      @error = session[:error]
    end
    erb :login
  end
end
