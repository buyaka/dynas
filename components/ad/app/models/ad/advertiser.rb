module Ad
  class Advertiser
    include NoBrainer::Document
    include NoBrainer::Document::Timestamps

    has_many :campaigns
    field :name, :type => String
    field :note, :type => String
    field :level, :type => Integer
  end
end
