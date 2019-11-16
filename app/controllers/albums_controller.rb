class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit]
  before_action :set_genres, only: [:new, :create, :edit, :update]

  # GET /albums
  # GET /albums.json
  def index
    if params[:genre].blank?
			@albums = Album.all.order("created_at DESC")
		else
			@genre_id = Genre.find_by(name: params[:genre]).id
			@albums = Album.where(:genre_id => @genre_id).order("created_at DESC")
		end
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
    @reviews =  @album.reviews.order("created_at DESC")
      unless @reviews.present?
        @avg_review = 0
      else
        @avg_review = @reviews.average(:rating).present? ? @reviews.average(:rating).round(2) : 0
    end
  end

  # GET /albums/new
  def new
    @album = current_user.albums.build
    # @album.genre_id = params[:genre_id]
  end

  # GET /albums/1/edit
  def edit
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = current_user.albums.build(album_params)
    @album.genre_id = params[:genre_id]
    

    respond_to do |format|
      if @album.save
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /albums/1
  # PATCH/PUT /albums/1.json
  def update
    @album.genre_id = params[:genre_id]
    

    if @album.update(album_params)
      redirect_to album_path(@album)
    else
      render 'edit'
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to albums_url, notice: 'Album was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_album
    @album = Album.find(params[:id])
  end

  def set_genres
    @genres = Genre.all.map { |g| [g.name, g.id] }
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def album_params
    params.require(:album).permit(:id, :title, :description, :artist, :image, :genre_id)
  end
end
