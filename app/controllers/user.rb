post '/users' do
    user = User.new(username: params[:username], password: params[:password])
    if user.save
      session[:user_id] = user.id
      redirect "/recommendations"
    else
      @error = "Whoops! Remember to fill out both the username and password fields, usernames must be unique!"
      erb :login
    end
end

get '/users/:id' do
  @user = User.find(params[:id])
  erb :"users/show"
end
