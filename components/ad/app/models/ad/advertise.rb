module Ad
  class Advertise
    include NoBrainer::Document
    include NoBrainer::Document::Timestamps

    #belongs_to :campaign
    #belongs_to :ad_type
    
    field :campaign_id
    field :ad_type_id
    field :name, :type => String
    field :note, :type => String
  
    field :redirect_url, :type => String
    field :html_code, :type => String
    field :image, :type => String
    field :alt_text, :type => String
  end
end