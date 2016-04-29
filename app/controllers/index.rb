get '/' do
  if session[:user_id]
    redirect '/recommendations'
  end
  if session[:errors]
    @error = session[:error]
  end
  erb :login
end
