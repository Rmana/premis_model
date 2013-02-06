class PremisFileObjectDatastream < ActiveFedora::NokogiriDatastream

  set_terminology do |t|
    t.root(:path=>'object', :xmlns=>'info:lc/xmlns/premis-v2', "xmlns:xsi"=>"http://www.w3.org/2001/XMLSchema-instance", :schema=>"http://www.loc.gov/standards/premis/v2/premis-v2-1.xsd")

    t.object_file_Identifier(:path=>"object[@xsi:type='file']/oxns:objectIdentifier")
      t.object_file_IdentifierType(:path=>"object[@xsi:type='file']/oxns:objectIdentifier/oxns:objectIdentifierType")
      t.object_file_IdentifierValue(:path=>"object[@xsi:type='file']/oxns:objectIdentifier/oxns:objectIdentifierValue")

    t.object_file_characteristics_CompositionLevel(:path=>"object[@xsi:type='file']/oxns:objectCharacteristics/oxns:compositionLevel")
    t.object_file_characteristics_fixitymessageDigestAlgorithm(:path=>"object[@xsi:type='file']/oxns:objectCharacteristics/oxns:fixity/oxns:messageDigestAlgorithm")
    t.object_file_characteristics_fixitymessageDigest(:path=>"object[@xsi:type='file']/oxns:objectCharacteristics/oxns:fixity/oxns:messageDigest")
    t.object_file_characteristics_fixitymessageDigestOriginator(:path=>"object[@xsi:type='file']/oxns:objectCharacteristics/oxns:fixity/oxns:messageDigestOriginator")
    t.object_file_characteristics_size(:path=>"object[@xsi:type='file']/oxns:objectCharacteristics/oxns:size")
    t.object_file_characteristics_formatName(:path=>"object[@xsi:type='file']/oxns:objectCharacteristics/oxns:format/oxns:formatDesignation/oxns:formatName")
    t.object_file_characteristics_formatVersion(:path=>"object[@xsi:type='file']/oxns:objectCharacteristics/oxns:format/oxns:formatDesignation/oxns:formatVersion")
    t.object_file_characteristics_formatRegistryName(:path=>"object[@xsi:type='file']/oxns:objectCharacteristics/oxns:format/oxns:formatRegistry/oxns:formatRegistryName")
    t.object_file_characteristics_formatRegistryKey(:path=>"object[@xsi:type='file']/oxns:objectCharacteristics/oxns:format/oxns:formatRegistry/oxns:formatRegistryKey")
    t.object_file_characteristics_formatRegistryRole(:path=>"object[@xsi:type='file']/oxns:objectCharacteristics/oxns:format/oxns:formatRegistry/oxns:formatRegistryRole")
    t.object_file_characteristics_creatingApplicationName(:path=>"object[@xsi:type='file']/oxns:objectCharacteristics/oxns:creatingApplication/oxns:creatingApplicationName")
    t.object_file_characteristics_creatingApplicationVersion(:path=>"object[@xsi:type='file']/oxns:objectCharacteristics/oxns:creatingApplication/oxns:creatingApplicationVersion")
    t.object_file_characteristics_dateCreatedByApplication(:path=>"object[@xsi:type='file']/oxns:objectCharacteristics/oxns:creatingApplication/oxns:dateCreatedByApplication")

    t.object_file_preservationLevelValue(:path=>"object[@xsi:type='file']/oxns:preservationLevel/oxns:preservationLevelValue")
    t.object_file_preservationLevelDateAssigned(:path=>"object[@xsi:type='file']/oxns:preservationLevel/oxns:preservationLevelDateAssigned")

    t.object_file_originalName(:path=>"object[@xsi:type='file']/oxns:originalName")

    t.object_file_linkingEventIdentifierType(:path=>"object[@xsi:type='file']/oxns:linkingEventIdentifier/oxns:linkingEventIdentifierType")
    t.object_file_linkingEventIdentifierValue(:path=>"object[@xsi:type='file']/oxns:linkingEventIdentifier/oxns:linkingEventIdentifierValue")

    t.object_file_linkingIntellectualEntityIdentifierType(:path=>"object[@xsi:type='file']/oxns:linkingIntellectualEntityIdentifier/oxns:linkingIntellectualEntityIdentifierType")
    t.object_file_linkingIntellectualEntityIdentifierValue(:path=>"object[@xsi:type='file']/oxns:linkingIntellectualEntityIdentifier/oxns:linkingIntellectualEntityIdentifierValue")

    t.object_file_linkingRightsStatementIdentifierType(:path=>"object[@xsi:type='file']/oxns:linkingRightsStatementIdentifier/oxns:linkingRightsStatementIdentifierType")
    t.object_file_linkingRightsStatementIdentifierValue(:path=>"object[@xsi:type='file']/oxns:linkingRightsStatementIdentifier/oxns:linkingRightsStatementIdentifierValue")

    # Relationships
    t.object_file_relationshipType(:path=>"object[@xsi:type='file']/oxns:relationship/oxns:relationshipType")
    t.object_file_relationshipSubType(:path=>"object[@xsi:type='file']/oxns:relationship/oxns:relationshipSubType")
    t.object_file_relatedObjectIdentifierType(:path=>"object[@xsi:type='file']/oxns:relationship/oxns:relatedObjectIdentification/oxns:relatedObjectIdentifierType")
    t.object_file_relatedObjectIdentifierValue(:path=>"object[@xsi:type='file']/oxns:relationship/oxns:relatedObjectIdentification/oxns:relatedObjectIdentifierValue")

    # still need Significant Properties section?

  end

  def self.xml_template
    Nokogiri::XML::Document.parse(File.new(File.join(File.dirname(__FILE__),'..', '..', '..', 'lib/medusa/default_datastream', "premis_file_object.xml")))
  end

  def self.object_file_Identifier_template
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.object_file_IdentifierType
      xml.object_file_IdentifierValue
    end
    return builder.doc.root
  end

  # Inserts a new object_identifier node into the premis object
  def insert_object_file_Identifier(opts={})
    node = PremisFileObjectDatastream.object_file_Identifier_template
    nodeset = self.find_by_terms(:object_file_Identifier)

    unless nodeset.nil?
      if nodeset.empty?
        self.ng_xml.root.add_child(node)
        index = 0
      else
        nodeset.after(node)
        index = nodeset.length
      end
      self.dirty = true
    end
      
    return node, index
  end

end
