class ArtworksController < ApplicationController
    # def index
    #     @artworks = Artwork.all
    #     render json: @artworks

    # end

    def index 
        # debugger
        if params.has_key?(:user_id)
            @artworks = Artwork.where(artist_id: params[:user_id])
        else
            @artworks = Artwork.all
        end 

        render :index
    end 

    def new 
        @artwork = Artwork.new
        render :new
    end

    def create
        @artwork = Artwork.new(artwork_params)

        if @artwork.save!
            redirect_to artwork_url(@artwork)
        else 
            render :new
        end 
    end

    def show
        @artwork = Artwork.find(params[:id])
        render :show
    end

    def edit
        @artwork = Artwork.find_by(id: params[:id])
        render :edit
    end
    def update
        @artwork = Artwork.find(params[:id])
        if @artwork.update(artwork_params)
            redirect_to artwork_url(@artwork)
        else
            render json: @artwork.errors.full_messages, status: unprocessable_entity
        end
    end

    def destroy
        @artwork = Artwork.find(params[:id])
        @artwork.destroy
        render json: @artwork
    end

    def favorite
        @artwork = Artwork.find(params[:id])
        @artwork.favorite = true
        @artwork.save
        render json: @artwork
    end

    def unfavorite
        @artwork = Artwork.find(params[:id])
        @artwork.favorite = false
        @artwork.save
        render json: @artwork
    end


    private
    def artwork_params
        params.require(:artwork).permit(:title, :image_url, :artist_id)
    end

    
end
