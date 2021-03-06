post '/users' do
  user = User.new(
  params['new']
  )
  if user.save
    session[:user_id] = user.id
    redirect "/"
  else
   @error = "Whoops! Remember to fill out the username, password and Zipcode fields, usernames must be unique!"
   erb :login
 end
end

get '/users/:id' do
  @user = User.find(params[:id])
  unless session[:user_id] == @user.id
    redirect '/'
  end
    erb :"users/show"
end

put '/users/:id' do
  user = User.find(params[:id])
  user.update(zip: params[:zip])
  redirect "/"
end
