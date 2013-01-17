class PremisAgentDatastream < ActiveFedora::NokogiriDatastream

  set_terminology do |t|
    t.root(:path=>'agent', :xmlns=>'info:lc/xmlns/premis-v2', :schema=>"http://www.loc.gov/standards/premis/v2/premis-v2-1.xsd")
 
    # repeatable
    t.agent_identifier(:path=>"agentIdentifier")
      t.agent_identifierType(:path=>"agentIdentifier/oxns:agentIdentifierType")
      t.agent_identifierValue(:path=>"agentIdentifier/oxns:agentIdentifierValue")
    
    # repeatable
    t.agent_name(:path=>"agentName")
    t.agent_note(:path=>"agentNote")
    t.agent_extension(:path=>"agentExtension")

    # non-repeatable
    t.agent_type(:path=>"agentType")

    # repeatable
    t.agent_linkingEventIdentifier(:path=>"linkingEventIdentifier")
      t.agent_linkingEventIdentifierType(:path=>"linkingEventIdentifier/oxns:linkingEventIdentifierType")
      t.agent_linkingEventIdentifierValue(:path=>"linkingEventIdentifier/oxns:linkingEventIdentifierValue")
    
    # repeatable
    t.agent_linkingRightsStatementIdentifier(:path=>"linkingRightsStatementIdentifier")
      t.agent_linkingRightsStatementIdentifierType(:path=>"linkingRightsStatementIdentifier/oxns:linkingRightsStatementIdentifierType")
      t.agent_linkingRightsStatementIdentifierValue(:path=>"linkingRightsStatementIdentifier/oxns:linkingRightsStatementIdentifierValue")
    
  end

  def self.xml_template
    Nokogiri::XML::Document.parse(File.new(File.join(File.dirname(__FILE__),'..', '..', '..', 'lib/medusa/default_datastream', "premis_agent.xml")))
  end

  def self.agent_identifier_template
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.agent_identifierType
      xml.agent_identifierValue
    end
    return builder.doc.root
  end

  # Inserts a new agent_identifier node into the premis agent
  def insert_agent_identifier(opts={})
    node = PremisAgentDatastream.agent_identifier_template
    nodeset = self.find_by_terms(:agent_identifier)

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
