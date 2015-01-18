module Ad
  class Campaign
    include NoBrainer::Document
    include NoBrainer::Document::Timestamps

    #belongs_to :advertiser
    has_many :ads
  
    field :name, :type => String
    field :note, :type => String
    field :advertiser_id
  end
end
