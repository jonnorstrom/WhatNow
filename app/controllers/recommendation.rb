get '/recommendations' do

  erb :"search_options"
end


## get mood from ajax. If mood is #{something}, then choose a random genre, send Netflix roulette a query with that genre
