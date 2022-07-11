require 'sinatra/base'
require 'sinatra/reloader'

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
  
  post "/" do
    return nil
  end

  post "/sort" do
    names = []
    names = params[:names]
    return names.sort.join(",")
  end
end