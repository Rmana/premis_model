class MatchAgentValidator < ActiveModel::Validator
  def validate(record)
    # Make sure type/value pairs
    if (record.agent_identifierType.length != record.agent_identifierValue.length)
      record.errors[:agent_identifierType] << "Agent Identifier type/value number mismatch"
    end

    # Medussa is not using these two pairs.... (not in delegate_to below)      
    # if (record.agent_linkingEventIdentifierType.length != record.agent_linkingEventIdentifierValue.length)
    #   record.errors[:agent_linkingEventIdentifierType] << "Agent Linking Event Identifier type/value number mismatch"
    # end

    # if (record.agent_linkingRightsStatementIdentifierType.length != record.agent_linkingRightsStatementIdentifierValue.length)
    #   record.errors[:agent_linkingRightsStatementIdentifierType] << "Agent Linking Rights Statement Identifier type/value number mismatch"
    # end
  end
end

class PremisAgent < ActiveFedora::Base
  include Hydra::ModelMixins::CommonMetadata
  include Hydra::ModelMixins::RightsMetadata

  has_and_belongs_to_many :premis_events, :property=>:is_agent_of, :inverse_of=>:has_agent
  has_and_belongs_to_many :premis_rights, :property=>:is_agent_of, :inverse_of=>:has_agent
  has_metadata :name => 'adescMetadata', :type => PremisAgentDatastream

  # has_metadata :name => 'PremisAgentInternal', :type => ActiveFedora::SimpleDatastream do |c|
  #   c.field :agent_creator, :string
  # end
  # delegate_to :PremisAgentInternal, [:agent_creator]

  delegate_to 'adescMetadata', [:agent_identifierType, :agent_identifierValue, :agent_name, :agent_note, :agent_extension, :agent_type,
                                :agent_linkingEventIdentifierType, :agent_linkingEventIdentifierValue, 
                                :agent_linkingRightsStatementIdentifierType, :agent_linkingRightsStatementIdentifierValue]

 #  validates :agent_identifierType, :presence=>true
 #  validates :agent_identifierValue, :presence=>true
 #  validates_with MatchAgentValidator

  def initialize(attrs={})
     super()
     # for testing...
     # print "attribute=#{attrs[:node]}\n"
     if attrs.nil?
       # just leave it to default node, if none given
     else
       if attrs[:node] and (attrs[:node].name == "document")
         one_agent_xml = attrs[:node].to_xml.gsub!(/\t|\b|\n/,'')
         self.datastreams['adescMetadata'].content = one_agent_xml
       else
         # TODO: Do something if node is NOT a premis document node
       end
     end
  end
end
