module Ad
  class AdType
    include NoBrainer::Document
    include NoBrainer::Document::Timestamps

    has_many :ads

    field :name, :type => String
    field :height, :type => Integer
    field :width, :type => Integer
    field :note, :type => String
  end
end