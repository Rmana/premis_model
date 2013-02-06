class PremisEventDatastream < ActiveFedora::NokogiriDatastream

  set_terminology do |t|
    t.root(:path=>'event', :xmlns=>'info:lc/xmlns/premis-v2', :schema=>"http://www.loc.gov/standards/premis/v2/premis-v2-1.xsd")
 
    # non-repeatable, mandatory
    t.event_identifier(:path=>"eventIdentifier")
      t.event_identifierType(:path=>"eventIdentifier/oxns:eventIdentifierType")
      t.event_identifierValue(:path=>"eventIdentifier/oxns:eventIdentifierValue")
    t.event_type(:path=>"eventType")
    t.event_DateTime(:path=>"eventDateTime")

    # non-repeatable, optional
    t.event_detail(:path=>"eventDetail")

    # repeatable, optional group
    t.event_linkingAgentIdentifier(:path=>"linkingAgentIdentifier")
      t.event_linkingAgentIdentifierType(:path=>"linkingAgentIdentifier/oxns:linkingAgentIdentifierType")
      t.event_linkingAgentIdentifierValue(:path=>"linkingAgentIdentifier/oxns:linkingAgentIdentifierValue")
      t.event_linkingAgentRole(:path=>"linkingAgentIdentifier/oxns:linkingAgentRole")
    
    # repeatable, optional group
    t.event_linkingObjectIdentifier(:path=>"linkingObjectIdentifier")
      t.event_linkingObjectIdentifierType(:path=>"linkingObjectIdentifier/oxns:linkingObjectIdentifierType")
      t.event_linkingObjectIdentifierValue(:path=>"linkingObjectIdentifier/oxns:linkingObjectIdentifierValue")
      t.event_linkingObjectRole(:path=>"linkingObjectRole/oxns:linkingObjectRole")
    
    # repeatable, optional
    t.event_outcomeInformation(:path=>"eventOutcomeInformation")
      t.event_outcome(:path=>"eventOutcomeInformation/oxns:eventOutcome")
      t.event_outcomeDetail(:path=>"eventOutcomeInformation/oxns:eventOutcomeDetail")
        t.event_outcomeDetailNote(:path=>"eventOutcomeInformation/oxns:eventOutcomeDetail/oxns:eventOutcomeDetailNote")
        t.event_outcomeDetailExtension(:path=>"eventOutcomeInformation/oxns:eventOutcomeDetail/oxns:eventOutcomeDetailExtension")
    
  end

  def self.xml_template
    Nokogiri::XML::Document.parse(File.new(File.join(File.dirname(__FILE__),'..', '..', '..', 'lib/medusa/default_datastream', "premis_event.xml")))
  end

  def self.event_identifier_template
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.event_identifierType
      xml.event_identifierValue
    end
    return builder.doc.root
  end

  # Inserts a new event_identifier node into the premis event
  def insert_event_identifier(opts={})
    node = PremisEventDatastream.event_identifier_template
    nodeset = self.find_by_terms(:event_identifier)

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
