require 'sinatra/base'
require 'sinatra/reloader'
require 'logger'

require './models/todos.rb'

class MockTodoApp < Sinatra::Base
  @@logger = Logger.new('./log/error.log')

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
      @@logger.error e.inspect
      return "Couldn't find Todo with 'id'=#{params[:id]}"
    end
    return todo.to_json
  end

  post '/todos' do
    request.body.rewind
    todo_params = JSON.parse request.body.read
    begin
      todo = Todo.create(todo_params["task"])
    rescue => e
      @@logger.error e.inspect
      return "Couldn't save"
    end
    return todo.to_json
  end

  delete '/todos/:id' do
    begin
      todo = Todo.find(params[:id])
      todo.destroy
    rescue => e
      @@logger.error e.inspect
      return "Couldn't delete Todo with 'id'=#{params[:id]}"
    end
    return {}.to_json
  end

  patch '/todos/:id' do
    begin
      todo = Todo.find(params[:id])
      params.each do |k, v|
        if todo[k]
          todo[k] = v
        end
      end
      todo.save
    rescue => e
      @@logger.error e.inspect
      return "Couldn't update Todo with 'id'=#{params[:id]}"
    end
    return todo.to_json
  end

end
