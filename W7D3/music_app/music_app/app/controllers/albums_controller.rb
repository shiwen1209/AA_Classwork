class AlbumsController < ApplicationController

    def new 
        render :new
    end

    def create 
        @album = Album.new(album_params)
        if @album.save 
            redirect_to album_url(@album)
        else 
            flash[:errors] = @band.errors.full_messages
            render :new
        end
    end

    def album_params
        params.require(:album).permit(:title, :year, :band_id, :album_type)
    end
end
