class MatchFolderObjectValidator < ActiveModel::Validator
  def validate(record)
    # Make sure type/value pairs
    if (record.object_folder_identifierType.length != record.object_folder_identifierValue.length)
      record.errors[:object_folder_identifierType] << "Identifier (folder) type/value number mismatch"
    end

    if (record.object_folder_linkingEventIdentifierType.length != record.object_folder_linkingEventIdentifierValue.length)
      record.errors[:object_folder_linkingEventIdentifierType] << "Linking Event Identifier type/value number mismatch"
    end

    if (record.object_folder_linkingIntellectualEntityIdentifierType.length != record.object_folder_linkingIntellectualEntityIdentifierValue.length)
      record.errors[:object_folder_linkingIntellectualEntityIdentifierType] << "Linking Intellectual Entity Identifier type/value number mismatch"
    end

    if (record.object_folder_linkingRightsStatementIdentifierType.length != record.object_folder_linkingRightsStatementIdentifierValue.length)
      record.errors[:object_folder_linkingRightsStatementIdentifierType] << "Linking Rights Statement Identifier type/value number mismatch"
    end

    if (record.object_folder_relatedObjectIdentifierType.length != record.object_folder_relatedObjectIdentifierValue.length)
      record.errors[:object_folder_relatedObjectIdentifierType] << "Related Object Identifier (relationship) type/value number mismatch"
    end

  end
end

class PremisFolderObject < PremisGeneral

  belongs_to :premis_folder_object, :property => :is_contained_in
  has_many :premis_file_objects, :property => :is_contained_in
  has_and_belongs_to_many :premis_events, :property=>:has_event, :inverse_of=>:is_event_of
  has_and_belongs_to_many :premis_rights, :property=>:has_rights, :inverse_of=>:has_rights_in 
  has_metadata :name => 'folodescMetadata', :type => PremisFolderObjectDatastream

  # has_metadata :name => 'PremisFolderObjectInternal', :type => ActiveFedora::SimpleDatastream do |c|
  #   c.field :folder_object_creator_in_fedora, :string
  # end
  # delegate_to :PremisFolderObjectInternal, [:folder_object_creator_in_fedora]

  delegate_to 'folodescMetadata', [:object_folder_identifierType, :object_folder_identifierValue,
                                :object_folder_preservationLevelValue, :object_folder_preservationLevelRationale, :object_folder_preservationLevelDateAssigned,
                                :object_folder_originalName,
                                :object_folder_linkingEventIdentifierType, :object_folder_linkingEventIdentifierValue,
                                :object_folder_linkingIntellectualEntityIdentifierType, :object_folder_linkingIntellectualEntityIdentifierValue,  
                                :object_folder_linkingRightsStatementIdentifierType, :object_folder_linkingRightsStatementIdentifierValue,
                                :object_folder_relationshipType, :object_folder_relationshipSubType, :object_folder_relatedObjectIdentifierType, :object_folder_relatedObjectIdentifierValue]

  validates :object_folder_identifierType, :presence=>true
  validates :object_folder_identifierValue, :presence=>true
  
  validates_with MatchFolderObjectValidator

  def initialize( attrs={} )
    super()
    # for testing...
    # print "name=#{attrs[:node].name}, attribute=#{attrs[:node]}\n"
    # TODO: Make sure this object is of type "folder"
    if attrs.nil?
      # just leave it to default node, if none given
    else
      if attrs[:node] and (attrs[:node].name == "document")
        one_object_xml = attrs[:node].to_xml.gsub!(/\t|\b|\n/,'')
        self.datastreams['folodescMetadata'].content = one_object_xml
      else
        # TODO: Do something if node not equal to "document" 
      end
    end
  end
end
