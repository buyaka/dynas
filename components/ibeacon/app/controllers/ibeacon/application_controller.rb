module Ibeacon
  class ApplicationController < ActionController::Base

  	before_filter :authenticate_member!
  	
  end
end