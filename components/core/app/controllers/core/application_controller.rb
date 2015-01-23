module Core
  class ApplicationController < ActionController::Base

		layout "frontend/guest"

  	helper_method :set_db

	def set_db
	  Thread.current[:member] = current_member.id
	end

	#Devise after sign in
	#Warden::Manager.after_authentication do |user,auth,opts|
	#	Thread.current[:member] = current_member.id
	#end

  end
end
