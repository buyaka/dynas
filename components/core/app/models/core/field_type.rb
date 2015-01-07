module Core
 class FieldType
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps
  NoBrainer::Document::DynamicAttributes

  field :name, :type => String
  field :value, :type => String
  field :note, :type => String
 end
end