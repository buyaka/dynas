module Ad
  class CampaignsController < ApplicationController
    before_filter :set_advertiser
    before_action :set_campaign, only: [:show, :edit, :update, :destroy]

    # GET /campaigns
    # GET /campaigns.json
    def index
      @campaigns = Campaign.where(:advertiser_id => @advertiser.id)
    end

    # GET /campaigns/1
    # GET /campaigns/1.json
    def show
    end

    # GET /campaigns/new
    def new
      @campaign = Campaign.new
    end

    # GET /campaigns/1/edit
    def edit
    end

    # POST /campaigns
    # POST /campaigns.json
    def create
      @campaign = Campaign.new(campaign_params)
      @campaign.advertiser_id = @advertiser.id

      respond_to do |format|
        if @campaign.save
          format.html { redirect_to @campaign, notice: 'Campaign was successfully created.' }
          format.json { render :show, status: :created, location: @campaign }
        else
          format.html { render :new }
          format.json { render json: @campaign.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /campaigns/1
    # PATCH/PUT /campaigns/1.json
    def update
      respond_to do |format|
        if @campaign.update(campaign_params)
          format.html { redirect_to @campaign, notice: 'Campaign was successfully updated.' }
          format.json { render :show, status: :ok, location: @campaign }
        else
          format.html { render :edit }
          format.json { render json: @campaign.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /campaigns/1
    # DELETE /campaigns/1.json
    def destroy
      @campaign.destroy
      respond_to do |format|
        format.html { redirect_to advertiser_campaigns_url(@advertiser), notice: 'Campaign was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
  
    def set_advertiser
      @advertiser = Advertiser.find(params[:advertiser_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campaign_params
      params.require(:campaign).permit(:name, :note, :advertiser_id)
    end
  end
end
