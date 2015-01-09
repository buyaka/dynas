module Core
	class Entity
	  include NoBrainer::Document
	  include NoBrainer::Document::Timestamps
  	  NoBrainer::Document::DynamicAttributes

	  store_in :database => ->{ "#{Thread.current[:member]}" }
	  #belongs_to :app

	  field :app_id, :type => String
	  field :name, :type => String
	  field :note, :type => String

	  validates_uniqueness_of :name
	  validates_length_of :name, maximum: 32, message: "exceeds maximum of 32 characters"
	  validates_length_of :name, minimum: 4, message: "exceeds minimum of 4 characters"
	end
end