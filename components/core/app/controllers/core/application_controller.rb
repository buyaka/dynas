module Core
  class ApplicationController < ActionController::Base

  	helper_method :set_db

	def set_db
	  Thread.current[:member] = current_member.id
	end
  end
end
