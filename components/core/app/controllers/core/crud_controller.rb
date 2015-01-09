module Core
  class CrudController < ApplicationController
    before_filter :get_required_data
    respond_to :json

    def index
      mdl = nil
      jdata = nil

      #mdl = params[:entity]
      puts mdl.to_s
      params[:crud].each do |key, value|
        mdl = value
      end

      if mdl == nil
          respond_with :status => 400
          return
      end

      NoBrainer.run { |r| 
        @datas = r.db(@member_id).table(mdl)
      }

      puts @datas.to_yaml

      #@datas.each do |e|
      #  puts e.name
      #end

      respond_with @datas
    end
    
    def show
    end

    # GET /boxes/new
    def new
      @box = Box.new(:app_id => @app.id)
    end

    # GET /boxes/1/edit
    def edit
    end

    # POST /boxes
    # POST /boxes.json
    def create
      mdl = nil
      jdata = nil
      params[:crud].each do |key, value|
        mdl = key
        jdata = value
      end

      #puts mdl.to_s
      #puts jdata.to_s
      
      if mdl == nil or jdata == nil 
          respond_with :status => 400
          return
      end

      NoBrainer.run { |r| 
        r.db(@member_id).table(mdl).insert(jdata)
      }

      #@box = Box.new(box_params)
      #@box.app_id = @app.id

      respond_to do |format|
        if @box.save
          format.json { render :show, status: :created, location: @box }
        else
          format.json { render json: @box.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /boxes/1
    # PATCH/PUT /boxes/1.json
    def update
      respond_to do |format|
        if @box.update(box_params)
          format.json { render :show, status: :ok, location: @box }
        else
          format.json { render json: @box.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /boxes/1
    # DELETE /boxes/1.json
    def destroy
      @box.destroy
      respond_to do |format|
        format.json { head :no_content }
      end
    end

    private

      def get_required_data
        @member_id = request.headers['MEMBERID'].to_s
        @app_id = request.headers['APPID'].to_s

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

        @app = App.find(@app_id)

        if @app == nil 
          respond_with :status => 402
          return
        end

      end

      # Use callbacks to share common setup or constraints between actions.
      def set_box
        @box = Box.find(params[:id])
      end

  end
end