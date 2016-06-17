class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  before_action :get_publishers, only: [:new, :edit]

  respond_to :html

  def index
    @albums = Album.all
    respond_with(@albums)
  end

  def show
    respond_with(@album)
  end

  def new
    @album = Album.new
    respond_with(@album)
  end

  def edit
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      most_recent = Album.get('most_recent')
      if most_recent.size < 4
        most_recent << @album
      else
        most_recent.shift.push(@album)
      end
      Album.set('most_recent', most_recent)
    end

    respond_with(@album)
  end

  def update
    @album.update(album_params)
    respond_with(@album)
  end

  def destroy
    @album.destroy
    respond_with(@album)
  end

  def newest
    @album = Album.last
    render 'show'
  end

  private
    def set_album
      @album = Album.find(params[:id])
    end

    def album_params
      params.require(:album).permit(:name, :cover_art, :publisher_id, :released_on)
    end

    def get_publishers
      @publishers = Publisher.all
    end

end
