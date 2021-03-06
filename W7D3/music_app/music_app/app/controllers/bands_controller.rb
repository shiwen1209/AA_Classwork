class BandsController < ApplicationController

    def index
        @bands = Band.all 
        render :index
    end

    def new 
        @band = Band.new
        render :new 
    end

    def create
        @band = Band.new(band_params)
        if @band.save
            render :show  #may need to be updated to redirect to show page
        else 
            flash[:errors] = @band.errors.full_messages
            render :new
        end
    end

    def update
        @band = Band.find_by(id: params[:id])
        if @band.update_attributes(band_params)
            redirect_to band_url(@band)
        else
            render :edit 
        end
    end

    def show
        @band = Band.find_by(id: params[:id])
        render :show
    end

    def edit
        @band = Band.find_by(id: params[:id])
        render :edit
    end

    def destroy
        @band = Band.find_by(id: params[:id])
        @band.destroy
        redirect_to bands_url
    end

    def band_params
        params.require(:band).permit(:name)
    end

end
