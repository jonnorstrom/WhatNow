post '/users' do
    user = User.new(username: params[:username], password: params[:password], zip: params[:zip])
    if user.save
      session[:user_id] = user.id
      redirect "/"
    else
      session[:error] = "Whoops! Remember to fill out the username, password and Zipcode fields, usernames must be unique!"
      redirect "/"
    end
end

get '/users/:id' do
  @user = User.find(params[:id])
  unless session[:user_id] == @user.id
    redirect '/'
  end
    erb :"users/show"
end

put '/users' do
  user = User.find_by(session[:id])
  user.update(zip: params[:zip])
  p user
  redirect "/users/#{user.id}"
end
