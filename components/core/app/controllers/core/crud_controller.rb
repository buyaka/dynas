module Core
  class CrudController < ApplicationController
    before_filter :get_required_data
    respond_to :json

    def index
      mdl = nil
      jdata = nil

      puts mdl.to_s
      params[:crud].each do |key, value|
        mdl = value
      end

      if mdl == nil
          respond_with :status => 400
          return
      end

      @datas = NoBrainer.run { |r| 
        r.db(@member_id).table(mdl)
      }

      respond_with @datas
    end
    
    def show
    end

    def new
      @box = Box.new(:app_id => @app.id)
    end

    def edit
    end

    def create
      mdl = nil
      jdata = nil
      params[:crud].each do |key, value|
        mdl = key
        jdata = value
      end
      
      if mdl == nil or jdata == nil 
          respond_with :status => 400
          return
      end

      @result = NoBrainer.run { |r| 
        r.db(@member_id).table(mdl).insert(jdata)
      }

      respond_with @result
    end

    def update
      respond_to do |format|
        if @box.update(box_params)
          format.json { render :show, status: :ok, location: @box }
        else
          format.json { render json: @box.errors, status: :unprocessable_entity }
        end
      end
    end

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

  end
end