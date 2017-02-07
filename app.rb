require 'sinatra/base'
require 'sinatra/reloader'

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

end
