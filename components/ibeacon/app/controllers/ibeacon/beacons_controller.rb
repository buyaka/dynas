module Ibeacon
  class BeaconsController < ApplicationController
    before_filter :get_required_data
    before_action :set_object, only: [:show, :edit, :update, :destroy]

    layout "frontend/main"

    def index
      @beacons = Beacon.all
    end

    def show
    end

    def new
      @beacon = Beacon.new
    end

    def edit
    end

    def create
      @beacon = Beacon.new(beacon_params)

      respond_to do |format|
        if @beacon.save
          format.html { redirect_to @beacon, notice: 'Beacon was successfully created.' }
          format.json { render :show, status: :created, location: @beacon }
        else
          format.html { render :new }
          format.json { render json: @beacon.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @beacon.update(beacon_params)
          format.html { redirect_to @beacon, notice: 'Beacon was successfully updated.' }
          format.json { render :show, status: :ok, location: @beacon }
        else
          format.html { render :edit }
          format.json { render json: @beacon.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @beacon.destroy
      respond_to do |format|
        format.html { redirect_to beacons_url, notice: 'Beacon was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      def set_object
        @beacon = Beacon.find(params[:id])
      end
      
      def beacon_params
        params.require(:beacon).permit(:uuid, :major, :minor)
      end

      def get_required_data_api

        @member_id = request.headers['MEMBERID'].to_s
        #@app_id = request.headers['APPID'].to_s

        if @member_id == nil or @app_id == nil
          respond_with :status => 400
          return
        end

        @member = Member.find(@member_id)
        if @member == nil 
          respond_with :status => 401
          return
        end

        Thread.current[:member] = @member_id

      end

      def get_required_data
        Thread.current[:member] = current_member.id
      end

  end
end