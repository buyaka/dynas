module Core
	class Field
	  include NoBrainer::Document
	  include NoBrainer::Document::Timestamps
  	NoBrainer::Document::DynamicAttributes

	  store_in :database => ->{ "#{Thread.current[:member]}" }

	  field :app_id, :type => String
	  field :entity_id, :type => String
	  field :name, :type => String
	  field :field_type, :type => String
	  field :note, :type => String

	  validates_uniqueness_of :name
	  validates_length_of :name, maximum: 32, message: "exceeds maximum of 32 characters"
	  validates_length_of :name, minimum: 1, message: "exceeds minimum of 1 characters"
	end
end