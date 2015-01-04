module Core
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
    def facebook
      @member = Member.find_for_facebook_oauth(request.env["omniauth.auth"]).first
  
      if @member.persisted?
        set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
        sign_in_and_redirect @member, :event => :authentication #this will throw if @member is not activated
      else
        session["devise.facebook_data"] = request.env["omniauth.auth"]
        redirect_to new_member_registration_url
      end
    end
  
    def twitter
      @member = Member.find_for_twitter_oauth(request.env["omniauth.auth"]).first
  
      if @member.persisted?
        set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
        sign_in_and_redirect @member, :event => :authentication
      else
        session["devise.twitter_data"] = request.env["omniauth.auth"]
        redirect_to new_member_registration_url
      end
    end
  
  end
end
