#require 'rails_helper'

module Service
  RSpec.describe MainController, :type => :controller do
  	describe "GET index" do
  		it "renders the index template" do
  			get :index
  			except(response).to render_template("index")
  		end
  	end

  end
end
