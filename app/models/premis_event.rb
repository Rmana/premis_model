class MatchEventValidator < ActiveModel::Validator
  def validate(record)
    if (record.event_identifierType.length != 1)
      record.errors[:event_identifierType] << "Event Identifier Type must be provided and used only once"
    end
    if (record.event_identifierValue.length != 1)
      record.errors[:event_identifierValue] << "Event Identifier Value must be provided and used only once"
    end
    if (record.event_type.length != 1)
      record.errors[:event_type] << "Event Type must be provided and used only once"
    end
    if (record.event_DateTime.length != 1)
      record.errors[:event_DateTime] << "Event Identifier DateTime must be provided and used only once"
    end
    # Make sure type/value pairs
    if (record.event_identifierType.length != record.event_identifierValue.length)
      record.errors[:event_identifierType] << "Event Identifier type/value number mismatch"
    end

    # TODO: validate more      
  end
end

class PremisEvent < ActiveFedora::Base
  include Hydra::ModelMixins::CommonMetadata
  include Hydra::ModelMixins::RightsMetadata

  has_and_belongs_to_many :premis_folder_objects, :property=>:is_event_of, :inverse_of=>:has_event
  has_and_belongs_to_many :premis_file_objects, :property=>:is_event_of, :inverse_of=>:has_event
  has_and_belongs_to_many :premis_agents, :property=>:is_event_of, :inverse_of=>:has_event
  has_metadata :name => 'edescMetadata', :type => PremisEventDatastream

  # has_metadata :name => 'PremisEventInternal', :type => ActiveFedora::SimpleDatastream do |c|
  #   c.field :event_creator_in_medusa, :string
  # end
  # delegate_to :PremisEventInternal, [:event_creator_in_medusa]

  delegate_to 'edescMetadata', [:event_identifierType, :event_identifierValue, :event_type, :event_DateTime, :event_detail,
                                :event_linkingAgentIdentifierType, :event_linkingAgentIdentifierValue, :event_linkingAgentRole,
                                :event_linkingObjectIdentifierType, :event_linkingObjectIdentifierValue, :event_linkingObjectRole,
                                :event_outcome, :event_outcomeDetailNote, :event_outcomeDetailExtension]

  validates :event_identifierType, :presence=>true
  validates :event_identifierValue, :presence=>true
  validates :event_type, :presence=>true
  validates :event_DateTime, :presence=>true
  validates_with MatchEventValidator

  def initialize(attrs={})
     super()
     # for testing...
     # print "attribute=#{attrs[:node]}\n"
     if attrs.nil?
       # just leave it to default node, if none given
     else
       if attrs[:node] and (attrs[:node].name == "document")
         one_event_xml = attrs[:node].to_xml.gsub!(/\t|\b|\n/,'')
         self.datastreams['edescMetadata'].content = one_event_xml
       else
         # TODO: Do something if node is NOT a premis document node
       end
     end
  end
end
