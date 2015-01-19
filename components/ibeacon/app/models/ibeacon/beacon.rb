module Ibeacon
	class Beacon
	  include NoBrainer::Document
	  include NoBrainer::Document::Timestamps
	  store_in :database => ->{ "#{Thread.current[:member]}" }

	  field :uuid, :type => String
	  field :major, :type => Integer
	  field :minor, :type => Integer
	  field :rssi, :type => String
	  
	  validates_uniqueness_of :uuid, :scope => [:major, :minor]
	end
end