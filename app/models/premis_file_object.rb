class MatchFileObjectValidator < ActiveModel::Validator
  def validate(record)
    # Make sure type/value pairs
    if (record.object_file_identifierType.length != record.object_file_identifierValue.length)
      record.errors[:object_file_identifierType] << "Identifier (file) type/value number mismatch"
    end

    if (record.object_file_linkingEventIdentifierType.length != record.object_file_linkingEventIdentifierValue.length)
      record.errors[:object_file_linkingEventIdentifierType] << "Linking Event Identifier type/value number mismatch"
    end

    if (record.object_file_linkingIntellectualEntityIdentifierType.length != record.object_file_linkingIntellectualEntityIdentifierValue.length)
      record.errors[:object_file_linkingIntellectualEntityIdentifierType] << "Linking Intellectual Entity Identifier type/value number mismatch"
    end

    if (record.object_file_linkingRightsStatementIdentifierType.length != record.object_file_linkingRightsStatementIdentifierValue.length)
      record.errors[:object_file_linkingRightsStatementIdentifierType] << "Linking Rights Statement Identifier type/value number mismatch"
    end

    if (record.object_file_relatedObjectIdentifierType.length != record.object_file_relatedObjectIdentifierValue.length)
      record.errors[:object_file_relatedObjectIdentifierType] << "Related Object Identifier (relationship) type/value number mismatch"
    end

  end
end

class PremisFileObject < PremisGeneral

  belongs_to :premis_folder_object, :property => :is_contained_in
  has_and_belongs_to_many :premis_events, :property=>:has_event, :inverse_of=>:is_event_of
  has_and_belongs_to_many :premis_rights, :property=>:has_rights, :inverse_of=>:has_rights_in
  has_metadata :name => 'fodescMetadata', :type => PremisFileObjectDatastream
  has_file_datastream :name => 'content', :type => FileContentDatastream

  # has_metadata :name => 'PremisFileObjectInternal', :type => ActiveFedora::SimpleDatastream do |c|
  #   c.field :file_object_creator_in_fedora, :string
  # end
  # delegate_to :PremisFileObjectInternal, [:file_object_creator_in_fedora]

  delegate_to 'fodescMetadata', [:object_file_identifierType, :object_file_identifierValue,
                                :object_file_characteristics_CompositionLevel, :object_file_characteristics_fixitymessageDigestAlgorithm, :object_file_characteristics_fixitymessageDigest, :object_file_characteristics_fixitymessageDigestOriginator, :object_file_characteristics_size, :object_file_characteristics_formatName, :object_file_characteristics_formatVersion, :object_file_characteristics_formatRegistryName, :object_file_characteristics_formatRegistryKey, :object_file_characteristics_formatRegistryRole, :object_file_characteristics_creatingApplicationName, :object_file_characteristics_creatingApplicationVersion, :object_file_characteristics_dateCreatedByApplication,
                                :object_file_preservationLevelValue, :object_file_preservationLevelDateAssigned,
                                :object_file_originalName,
                                :object_file_linkingEventIdentifierType, :object_file_linkingEventIdentifierValue,
                                :object_file_linkingIntellectualEntityIdentifierType, :object_file_linkingIntellectualEntityIdentifierValue,  
                                :object_file_linkingRightsStatementIdentifierType, :object_file_linkingRightsStatementIdentifierValue,
                                :object_file_relationshipType, :object_file_relationshipSubType, :object_file_relatedObjectIdentifierType, :object_file_relatedObjectIdentifierValue]

  validates :object_file_identifierType, :presence=>true
  validates :object_file_identifierValue, :presence=>true
  validates :object_file_characteristics_CompositionLevel, :presence=>true
  
  validates_with MatchFileObjectValidator

  def initialize( attrs={} )
    super()
    # for testing...
    # print "attribute=#{attrs[:node]}\n"
    # TODO: Make sure this object is of type "file"
    if attrs.nil?
      # just leave it to default node, if none given
    else
      if attrs[:node] and (attrs[:node].name == "document")
        one_object_xml = attrs[:node].to_xml.gsub!(/\t|\b|\n/,'')
        self.datastreams['fodescMetadata'].content = one_object_xml
      else
        # TODO: Do something if node not equal to "document" 
      end
    end
  end
end
