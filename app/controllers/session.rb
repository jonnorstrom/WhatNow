get '/login' do
    user = User.find_by(username: params[:username])
    if user
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/users/#{user.id}"
      else
        @error = "Whoops! Remember to fill out both the username and password fields, usernames must be unique!"
        erb :login
      end
    else
      @error = "Whoops! Remember to fill out both the username and password fields, usernames must be unique!"
      erb :login
    end
end
