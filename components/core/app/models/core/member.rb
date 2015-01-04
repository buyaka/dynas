module Core
  class Member
    include NoBrainer::Document
    include NoBrainer::Document::Timestamps
    NoBrainer::Document::DynamicAttributes
  
    # Include default devise modules. Others available are:
    # :lockable, :timeoutable 
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, #:trackable, 
           :validatable,
  	       :confirmable, :omniauthable

    ## Database authenticatable
    field :email,              :type => String, :default => ""
    field :encrypted_password, :type => String, :default => ""

    ## Recoverable
    field :reset_password_token,   :type => String
    field :reset_password_sent_at, :type => Time

    ## Rememberable
    field :remember_created_at, :type => Time

    ## Trackable
    field :sign_in_count,      :type => Integer, :default => 0
    field :current_sign_in_at, :type => Time
    field :last_sign_in_at,    :type => Time
    field :current_sign_in_ip, :type => String
    field :last_sign_in_ip,    :type => String

    ## Confirmable
    field :confirmation_token,   :type => String
    field :confirmed_at,         :type => Time
    field :confirmation_sent_at, :type => Time
    field :unconfirmed_email,    :type => String # Only if using reconfirmable

    ## Lockable
    # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
    # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
    # field :locked_at,       :type => Time

    field :authentication_token,	:type => String
    field :provider,	:type => String,	:default => ""
    field :uid,	:type => String

    def self.find_for_facebook_oauth(auth)
      member = Member.where(:provider => auth.provider, :uid => auth.uid)
      if member
        return member
      else
        registered_member = Member.where(:email => auth.info.email).first
        if registered_member
  	 return registered_member
        else
  	 member = Member.create(name:auth.info.name,
  			        provider:auth.provider,
  				uid:auth.uid,
  				email:auth.info.email,
  				password:Devise.friendly_token[0,20])
  	return member
        end
      end
    end

    def self.new_with_session(params, session)
      super.tap do |member|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
          member.email = data["email"] if member.email.blank?
        end
      end
    end

  end
end
