post '/login' do
    user = User.find_by(username: params[:username])
    if user
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/"
      else
        session[:error] = "Whoops! Remember to fill out both the username and password fields, usernames must be unique!"
        redirect '/'
      end
    else
      session[:error] = "Whoops! Remember to fill out both the username and password fields, usernames must be unique!"
      redirect '/'
    end
end

get '/logout' do
  session.delete(:user_id)
  redirect '/'
end
