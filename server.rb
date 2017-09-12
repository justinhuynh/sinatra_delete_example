require 'sinatra'
require "sinatra/reloader"
require 'pry'

set :bind, '0.0.0.0'  # bind to all interfaces

get '/' do
  @ingredients = File.readlines('ingredients.txt')
  erb :index
end

post '/ingredients' do
  ingredient = params['ingredient']

  File.open('ingredients.txt', 'a') do |file|
    file.puts(ingredient)
  end

  redirect '/'
end

delete '/ingredient/:id' do
  line_number = params[:id].to_i

  file_contents = File.readlines("ingredients.txt")
  file_contents.delete_at(line_number)
  File.write("ingredients.txt", file_contents.join)

  redirect "/"
end
