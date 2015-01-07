module Core
  class WithdbController < ApplicationController
  	before_filter :authenticate_member!
  	before_filter :set_db
  end
end
