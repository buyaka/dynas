module Ad
  class AdvertisersController < ApplicationController
    before_action :set_advertiser, only: [:show, :edit, :update, :destroy]

    layout "frontend/main"

    # GET /advertisers
    # GET /advertisers.json
    def index
      @advertisers = Advertiser.all
    end

    # GET /advertisers/1
    # GET /advertisers/1.json
    def show
    end

    # GET /advertisers/new
    def new
      @advertiser = Advertiser.new
    end

    # GET /advertisers/1/edit
    def edit
    end

    # POST /advertisers
    # POST /advertisers.json
    def create
      @advertiser = Advertiser.new(advertiser_params)

      respond_to do |format|
        if @advertiser.save
          format.html { redirect_to @advertiser, notice: 'Advertiser was successfully created.' }
          format.json { render :show, status: :created, location: @advertiser }
        else
          format.html { render :new }
          format.json { render json: @advertiser.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /advertisers/1
    # PATCH/PUT /advertisers/1.json
    def update
      respond_to do |format|
        if @advertiser.update(advertiser_params)
          format.html { redirect_to @advertiser, notice: 'Advertiser was successfully updated.' }
          format.json { render :show, status: :ok, location: @advertiser }
        else
          format.html { render :edit }
          format.json { render json: @advertiser.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /advertisers/1
    # DELETE /advertisers/1.json
    def destroy
      @advertiser.destroy
      respond_to do |format|
        format.html { redirect_to advertisers_url, notice: 'Advertiser was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_advertiser
      @advertiser = Advertiser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def advertiser_params
      params.require(:advertiser).permit(:name, :note, :level)
    end
  end
end
