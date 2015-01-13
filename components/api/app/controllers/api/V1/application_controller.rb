module Api
  module V1
		class ApplicationController < ActionController::Base
		  respond_to :json
		  before_filter :set_format

		  def set_format
		    request.format = :json
		  end
		end
	end
end