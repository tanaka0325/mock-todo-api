require 'sinatra/base'
require 'sinatra/reloader'

require './models/todos.rb'

class MockTodoApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  before do
    content_type :json
  end

  get '/' do
    "hello world!"
  end

  get '/todos/?' do
    todos = Todo.all
    return todos.to_json
  end

  get '/todos/:id' do
    begin
      todo = Todo.find(params[:id])
    rescue => e
      return "Couldn't find Todo with 'id'=#{params[:id]}"
    end
    return todo.to_json
  end

end
