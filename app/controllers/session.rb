get '/login' do
  erb :login
end

post '/login' do
  user = User.find_by(username: params[:username])
  if user
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/"
    else
      @error = "Whoops! Wrong username/password combination."
      erb :login
    end
  else
    @error = "Whoops! Wrong username/password combination."
    erb :login
  end
end

get '/logout' do
  session.delete(:user_id)
  session.delete(:mood)
  session.delete(:redirect)
  redirect '/'
end
