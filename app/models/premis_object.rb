class MatchObjectValidator < ActiveModel::Validator
  def validate(record)
    # Make sure type/value pairs
    if (record.object_representationIdentifierType.length != record.object_representationIdentifierValue.length)
      record.errors[:object_representationIdentifierType] << "Identifier (representation) type/value number mismatch"
    end
      
    if (record.object_fileIdentifierType.length != record.object_fileIdentifierValue.length)
      record.errors[:object_fileIdentifierType] << "Identifier (file) type/value number mismatch"
    end

    if (record.object_linkingEventIdentifierType.length != record.object_linkingEventIdentifierValue.length)
      record.errors[:object_linkingEventIdentifierType] << "Linking Event Identifier type/value number mismatch"
    end

    if (record.object_linkingIntellectualEntityIdentifierType.length != record.object_linkingIntellectualEntityIdentifierValue.length)
      record.errors[:object_linkingIntellectualEntityIdentifierType] << "Linking Intellectual Entity Identifier type/value number mismatch"
    end

    if (record.object_linkingRightsStatementIdentifierType.length != record.object_linkingRightsStatementIdentifierValue.length)
      record.errors[:object_linkingRightsStatementIdentifierType] << "Linking Rights Statement Identifier type/value number mismatch"
    end

    if (record.object_relatedObjectIdentifierType.length != record.object_relatedObjectIdentifierValue.length)
      record.errors[:object_relatedObjectIdentifierType] << "Related Object Identifier (relationship) type/value number mismatch"
    end

  end
end

class PremisObject < ActiveFedora::Base
  include Hydra::ModelMixins::CommonMetadata
  include Hydra::ModelMixins::RightsMetadata

  belongs_to :premis_container, :property => :is_object_of
  has_metadata :name => 'odescMetadata', :type => PremisObjectDatastream

  # has_metadata :name => 'PremisObjectInternal', :type => ActiveFedora::SimpleDatastream do |c|
  #   c.field :object_creator, :string
  # end
  # delegate_to :PremisObjectInternal, [:object_creator]

  delegate_to 'odescMetadata', [:object_representationIdentifierType, :object_representationIdentifierValue, :object_fileIdentifierType, :object_fileIdentifierValue,
                                :object_characteristics_CompositionLevel, :object_characteristics_fixitymessageDigestAlgorithm, :object_characteristics_fixitymessageDigest, :object_characteristics_fixitymessageDigestOriginator, :object_characteristics_size, :object_characteristics_formatName, :object_characteristics_formatVersion, :object_characteristics_formatRegistryName, :object_characteristics_formatRegistryKey, :object_characteristics_formatRegistryRole, :object_characteristics_creatingApplicationName, :object_characteristics_creatingApplicationVersion, :object_characteristics_dateCreatedByApplication,
                                :object_preservationLevelValue, :object_preservationLevelDateAssigned,
                                :object_originalName,
                                :object_linkingEventIdentifierType, :object_linkingEventIdentifierValue,
                                :object_linkingIntellectualEntityIdentifierType, :object_linkingIntellectualEntityIdentifierValue,  
                                :object_linkingRightsStatementIdentifierType, :object_linkingRightsStatementIdentifierValue,
                                :object_relationshipType, :object_relationshipSubType, :object_relatedObjectIdentifierType, :object_relatedObjectIdentifierValue]

  validates_with MatchObjectValidator

  def initialize( attrs={} )
    super()
    # for testing...
    # print "attribute=#{attrs[:node]}\n"
    if attrs[:node] and (attrs[:node].name == "object")
      one_object_xml = attrs[:node].to_xml.gsub!(/\t|\b|\n/,'')
      self.datastreams['odescMetadata'].content = one_object_xml
     else
       # TODO: Do something if node is nil or not equal to "object"
     end
  end
end
