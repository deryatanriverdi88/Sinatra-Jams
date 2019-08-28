require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :method_override, true
  end

  get "/" do
    erb :welcome
  end

  get "/artist" do
    if params[:search_name]
      @artists = Artist.where("name LIKE ?", "%#{params[:search_name]}%")
    else
      @artists = Artist.all
    end
    erb :index
  end

  get "/artist/new" do
    erb :new
  end

  post "/artist" do
    @artist = Artist.create(params[:artist])
    redirect "/artist/#{@artist.id}"
  end

  get "/artist/:id" do
    @artist = Artist.find(params[:id])
    erb :show
  end

  get '/artist/:id/edit' do
    @artist = Artist.find(params[:id])
    erb :edit
  end

  patch "/artist/:id" do
    @artist = Artist.find(params[:id])
    @artist.update(params[:artist])
    redirect "/artist/#{@artist.id}"
  end

  delete "/artist/:id" do
    @artist = Artist.find(params[:id])
    @artist.destroy
    redirect "/artist"
  end


end
