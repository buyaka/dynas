require 'json'

module Api
  module V1
    class CrudController < ApplicationController
      before_filter :get_required_data
      respond_to :json

      def index
        @datas = NoBrainer.run { |r| 
          r.db(@member_id).table(@mdl)
        }
        
        respond_with(@datas, :status => 200)
      end
      
      def show
        data_hash = JSON.parse(@jdata.to_json)
        data_id = data_hash['id'].to_s

        if data_id == nil
          respond_with("{error: \"ID not found!\"}", :status => 200, :location => nil)
          return
        end

        @result = NoBrainer.run { |r| 
          r.db(@member_id).table(@mdl).get(data_id)
        }

        
        if @result["errors"] == 0
          respond_with(@result, :status => 200, :location => nil)
        else
          retVal = {"message"=> "fail"}
          respond_with(retVal, :status => 400, :location => nil)
        end
      end

      def create
        if @jdata == nil 
            respond_with("data parameter required",:status => 405, :location => nil)
            return
        end

        @result = NoBrainer.run { |r| 
          r.db(@member_id).table(@mdl).insert(@jdata)
        }
        
        if @result["errors"] == 0
          retVal = {"message"=> "success"}
          respond_with(retVal, :status => 200, :location => nil)
        else
          retVal = {"message"=> "fail"}
          respond_with(retVal, :status => 400, :location => nil)
        end
      end

      def update
        data_hash = JSON.parse(@jdata.to_json)
        data_id = data_hash['id'].to_s

        if data_id == nil
          respond_with("{error: \"ID not found!\"}", :status => 200, :location => nil)
          return
        end

        @result = NoBrainer.run { |r| 
          r.db(@member_id).table(@mdl).get(data_id).update(@jdata)
        }
        
        if @result["errors"] == 0
          retVal = {"message"=> "success"}
          respond_with(retVal, :status => 200, :location => nil)
        else
          retVal = {"message"=> "fail"}
          respond_with(retVal, :status => 400, :location => nil)
        end
      end

      def destroy
        data_hash = JSON.parse(@jdata.to_json)
        data_id = data_hash['id'].to_s

        if data_id == nil
          retVal = {"message"=> "ID not found!"}
          respond_with(retVal, :status => 400, :location => nil)
          return
        end

        @result = NoBrainer.run { |r| 
          r.db(@member_id).table(@mdl).get(data_id).delete()
        }
        
        if @result["errors"] == 0
          retVal = {"message"=> "success"}
          respond_with(retVal, :status => 200, :location => nil)
        else
          retVal = {"message"=> "fail"}
          respond_with(retVal, :status => 400, :location => nil)
        end
        
      end

      private

        def get_required_data

          crud_params
          @mdl = nil
          @jdata = nil
          @member_id = request.headers['MEMBERID'].to_s
          @app_id = request.headers['APPID'].to_s

          if @member_id == nil or @app_id == nil
            respond_with :status => 400
            return
          end

          @member = Core::Member.find(@member_id)
          if @member == nil 
            respond_with :status => 401
            return
          end

          Thread.current[:member] = @member_id
          @app = Core::App.find(@app_id)
          if @app == nil 
            respond_with :status => 402
            return
          end

          @mdl = params[:entity].to_s
          @jdata = params[:data]
          
        
          puts @jdata.to_json
          
          if @mdl == nil
            respond_with :status => 403
            return
          end

        end

        def crud_params
          params.require(:entity)
        end

    end
  end
end