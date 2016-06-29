class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  before_action :get_publishers, only: [:new, :edit]

  respond_to :html, :json

  def index
    @albums = Album.joins(:publisher).select("albums.id, albums.name, albums.cover_art, albums.released_on, publishers.name as owner")
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
      Album.consider_add('most_recent',@album)
    end
    respond_with(@album)
  end

  # def create
  #   @album = Album.new(album_params)
  #   if @album.save
  #     if Album.get(:most_recent).size < 4
  #       Album.set(:most_recent, Album.get(:most_recent).to_a.push(@album) )
  #     else
  #       new_store = []
  #       Album.get(:most_recent).to_a.each do |album|
  #         new_store << album unless Date.strptime(album.released_on, '%Y-%m-%d') > Date.strptime(@album.released_on, '%Y-%m-%d')
  #       end
  #
  #       if new_store.size < 4
  #         new_store.push(obj)
  #       end
  #       Album.set(:most_recent, new_store)
  #     end
  #   end
  #   respond_with(@album)
  # end
  def update
    if @album.update(album_params)
      Album.consider_add('most_recent',@album)
    end
    respond_with(@album)
  end
  # def update
  #   if @album.update(album_params)
  #     old_store = Album.get(:most_recent)
  #     if old_store.size < 4
  #       old_store.to_a.each_with_index do |album, ind|
  #         if @album.id == album.id
  #           old_store.delete_at(ind)
  #           old_store.push(@album).sort_by &:released_on
  #         end
  #       end
  #       Album.set(:most_recent, old_store )
  #     else
  #       new_store = []
  #       Album.get(:most_recent).to_a.each do |album|
  #         new_store << album unless Date.strptime(album.released_on, '%Y-%m-%d') > Date.strptime(@album.released_on, '%Y-%m-%d')
  #       end
  #
  #       if new_store.size < 4
  #         new_store.push(@album)
  #       end
  #       Album.set(:most_recent, new_store)
  #     end
  #   end
  #   respond_with(@album)
  # end

  def destroy
    @album.destroy
    respond_with(@album)
  end

  def newest
    @album = Album.most_recent(1).first
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
