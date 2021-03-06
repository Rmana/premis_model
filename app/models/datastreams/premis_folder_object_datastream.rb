class PremisFolderObjectDatastream < ActiveFedora::NokogiriDatastream

  set_terminology do |t|
    t.root(:path=>'object', :xmlns=>'info:lc/xmlns/premis-v2', "xmlns:xsi"=>"http://www.w3.org/2001/XMLSchema-instance", :schema=>"http://www.loc.gov/standards/premis/v2/premis-v2-1.xsd")

    t.object_folder_identifier(:path=>"object[@xsi:type='representation']/oxns:objectIdentifier")
      t.object_folder_identifierType(:path=>"object[@xsi:type='representation']/oxns:objectIdentifier/oxns:objectIdentifierType")
      t.object_folder_identifierValue(:path=>"object[@xsi:type='representation']/oxns:objectIdentifier/oxns:objectIdentifierValue")

    t.object_folder_originalName(:path=>"object[@xsi:type='representation']/oxns:originalName")

    t.object_folder_preservationLevelValue(:path=>"object[@xsi:type='representation']/oxns:preservationLevel/oxns:preservationLevelValue")
    t.object_folder_preservationLevelRationale(:path=>"object[@xsi:type='representation']/oxns:preservationLevel/oxns:preservationLevelRationale")
    t.object_folder_preservationLevelDateAssigned(:path=>"object[@xsi:type='representation']/oxns:preservationLevel/oxns:preservationLevelDateAssigned")

    t.object_folder_linkingEventIdentifierType(:path=>"object[@xsi:type='representation']/oxns:linkingEventIdentifier/oxns:linkingEventIdentifierType")
    t.object_folder_linkingEventIdentifierValue(:path=>"object[@xsi:type='representation']/oxns:linkingEventIdentifier/oxns:linkingEventIdentifierValue")

    t.object_folder_linkingIntellectualEntityIdentifierType(:path=>"object[@xsi:type='representation']/oxns:linkingIntellectualEntityIdentifier/oxns:linkingIntellectualEntityIdentifierType")
    t.object_folder_linkingIntellectualEntityIdentifierValue(:path=>"object[@xsi:type='representation']/oxns:linkingIntellectualEntityIdentifier/oxns:linkingIntellectualEntityIdentifierValue")

    t.object_folder_linkingRightsStatementIdentifierType(:path=>"object[@xsi:type='representation']/oxns:linkingRightsStatementIdentifier/oxns:linkingRightsStatementIdentifierType")
    t.object_folder_linkingRightsStatementIdentifierValue(:path=>"object[@xsi:type='representation']/oxns:linkingRightsStatementIdentifier/oxns:linkingRightsStatementIdentifierValue")

    # Relationships
    t.object_folder_relationshipType(:path=>"object[@xsi:type='representation']/oxns:relationship/oxns:relationshipType")
    t.object_folder_relationshipSubType(:path=>"object[@xsi:type='representation']/oxns:relationship/oxns:relationshipSubType")
    t.object_folder_relatedObjectIdentifierType(:path=>"object[@xsi:type='representation']/oxns:relationship/oxns:relatedObjectIdentification/oxns:relatedObjectIdentifierType")
    t.object_folder_relatedObjectIdentifierValue(:path=>"object[@xsi:type='representation']/oxns:relationship/oxns:relatedObjectIdentification/oxns:relatedObjectIdentifierValue")

    # still need Significant Properties section?

  end

  def self.xml_template
    Nokogiri::XML::Document.parse(File.new(File.join(File.dirname(__FILE__),'..', '..', '..', 'lib/medusa/default_datastream', "premis_folder_object.xml")))
  end

  def self.object_folder_identifier_template(type, value)
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.objectIdentifier do
        xml.objectIdentifierType_ type
        xml.objectIdentifierValue_ value
      end
    end
    return builder.doc.root
  end

  # Inserts a new object_folder_identifier node into the premis folder object.
  #   USE: if a is PremisObject,
  #      a.datastreams['adescMetadata'].insert_object_folder_identifier(:object_folder_identifierType=>"type_here", :object_folder_identifierValue=>"value_here")
  #      a.datastreams['adescMetadata'].save    OR a.save to save premis object, rather than just datastream
  def insert_object_folder_identifier(opts={})
    type = nil
    if !opts[:object_folder_identifierType].nil?
       type = opts[:object_folder_identifierType]
    end
    value = nil
    if !opts[:object_folder_identifierValue].nil?
       value = opts[:object_folder_identifierValue]
    end
    node = PremisFolderObjectDatastream.object_folder_identifier_template(type, value)
    nodeset = self.find_by_terms(:object_folder_identifier)

    unless nodeset.nil?
      if nodeset.empty?
        self.ng_xml.root.add_child(node)
        index = 0
      else
        nodeset.after(node)
        index = nodeset.length
      end
      # deprecated...
      # self.dirty = true
    end
      
    return node, index
  end

end
