class ArtworkSharesController < ApplicationController

    def create
        @artworkshare = ArtworkShare.new(artwork_share_params)

        if @artworkshare.save!
            render json: @artworkshare
        else 
            render json: @artworkshare.errors.full_messages, status: unprocessable_entity
        end 
    end

    def destroy
        @artworkshare = ArtworkShare.find(params[:id])
        @artworkshare.destroy
        render json: @artworkshare
    end

    def favorite
        @artworkshare = ArtworkShare.find(params[:id])
        @artworkshare.favorite = true
        @artworkshare.save
        render json: @artworkshare
    end

    def unfavorite
        @artworkshare = ArtworkShare.find(params[:id])
        @artworkshare.favorite = false
        @artworkshare.save
        render json: @artworkshare
    end

    private
    def artwork_share_params
        params.require(:artworkshare).permit(:artwork_id, :viewer_id)
    end


end
