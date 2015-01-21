module Ibeacon
	class Beacon
	  include NoBrainer::Document
	  include NoBrainer::Document::Timestamps
	  store_in :database => ->{ "#{Thread.current[:member]}" }

	  field :uuid, :type => String
	  field :major, :type => Integer, :default => 0
	  field :minor, :type => Integer, :default => 0
	  field :rssi, :type => String
	  field :note, :type => String
	  
	  validates_uniqueness_of :uuid, :scope => [:major, :minor]
	end
end