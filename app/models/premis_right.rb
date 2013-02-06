class MatchRightValidator < ActiveModel::Validator
  def validate(record)
    # Make sure type/value pairs
    if (record.right_identifierType.length != record.right_identifierValue.length)
      record.errors[:right_identifierType] << "Rights Identifier type/value number mismatch"
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

class PremisRight < ActiveFedora::Base
  include Hydra::ModelMixins::CommonMetadata
  include Hydra::ModelMixins::RightsMetadata

  has_and_belongs_to_many :premis_file_objects, :property=>:has_rights_in, :inverse_of=>:has_rights 
  has_and_belongs_to_many :premis_agents, :property=>:has_agent, :inverse_of=>:is_agent_of 
  has_metadata :name => 'rdescMetadata', :type => PremisRightDatastream

  # has_metadata :name => 'PremisAgentInternal', :type => ActiveFedora::SimpleDatastream do |c|
  #   c.field :agent_creator, :string
  # end
  # delegate_to :PremisAgentInternal, [:agent_creator]

  delegate_to 'rdescMetadata', [:right_StatementIdentifierType, :right_StatementIdentifierValue, :right_copyrightStatus, :right_copyrightJurisdiction,
                                :right_linkingObjectIdentifierType_GrantedAct, :right_GrantedRestriction
                                :right_linkingObjectIdentifierType, :right_linkingObjectIdentifierValue, :right_linkingObjectRole,
                                :right_linkingAgentIdentifierType, :right_linkingAgentIdentifierValue, :right_linkingAgentRole]  

  validates_with MatchRightValidator

  def initialize(attrs={})
     super()
     # for testing...
     # print "attribute=#{attrs[:node]}\n"
     if attrs.nil?
       # just leave it to default node, if none given
     else
       if attrs[:node] and (attrs[:node].name == "document")
         one_right_xml = attrs[:node].to_xml.gsub!(/\t|\b|\n/,'')
         self.datastreams['rdescMetadata'].content = one_right_xml
       else
         # TODO: Do something if node is NOT a premis document node
       end   
     end
  end
end
