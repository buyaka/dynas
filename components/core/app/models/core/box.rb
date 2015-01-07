module Core
class Box
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  store_in :database => ->{ "#{Thread.current[:member]}" }

  #belongs_to :app

  field :name, :type => String
  field :app_id, :type => String
  field :note, :type => String
end
end