class PremisRightDatastream < ActiveFedora::NokogiriDatastream

  set_terminology do |t|
    t.root(:path=>'rights', :xmlns=>'info:lc/xmlns/premis-v2', :schema=>"http://www.loc.gov/standards/premis/v2/premis-v2-1.xsd")
 
    t.right_Statement(:path=>"rightsStatement")
      # non-repeatable, mandatory
      t.right_StatementIdentifier(:path=>"rightsStatement/oxns:rightsStatementIdentifier")
        t.right_StatementIdentifierType(:path=>"rightsStatement/oxns:rightsStatementIdentifier/oxns:rightsStatementIdentifierType")
        t.right_StatementIdentifierValue(:path=>"rightsStatement/oxns:rightsStatementIdentifier/oxns:rightsStatementIdentifierValue")
      t.right_Basis(:path=>"rightsStatement/oxns:rightsBasis")

      # non-repeatable, optional (group)
      t.right_copyrightInformation(:path=>"rightsStatement/oxns:copyrightInformation")
        t.right_copyrightStatus(:path=>"rightsStatement/oxns:copyrightInformation/oxns:copyrightStatus")
        t.right_copyrightJurisdiction(:path=>"rightsStatement/oxns:copyrightInformation/oxns:copyrightJurisdiction")

      # repeatable, optional (group)
      t.right_Granted(:path=>"rightsStatement/oxns:rightsGranted")
        t.right_linkingObjectIdentifierType_GrantedAct(:path=>"rightsStatement/oxns:rightsGranted/oxns:act")
        t.right_GrantedRestriction(:path=>"rightsStatement/oxns:rightsGranted/oxns:restriction")

      # repeatable, optional group
      t.right_linkingObjectIdentifier(:path=>"rightsStatement/oxns:linkingObjectIdentifier")
        t.right_linkingObjectIdentifierType(:path=>"rightsStatement/oxns:linkingObjectIdentifier/oxns:linkingObjectIdentifierType")
        t.right_linkingObjectIdentifierValue(:path=>"rightsStatement/oxns:linkingObjectIdentifier/oxns:linkingObjectIdentifierValue")
        t.right_linkingObjectRole(:path=>"rightsStatement/oxns:linkingObjectIdentifier/oxns:linkingObjectRole")

      # repeatable, optional group
      t.right_linkingAgentIdentifier(:path=>"rightsStatement/oxns:linkingAgentIdentifier")
        t.right_linkingAgentIdentifierType(:path=>"rightsStatement/oxns:linkingAgentIdentifier/oxns:linkingAgentIdentifierType")
        t.right_linkingAgentIdentifierValue(:path=>"rightsStatement/oxns:linkingAgentIdentifier/oxns:linkingAgentIdentifierValue")
        t.right_linkingAgentRole(:path=>"rightsStatement/oxns:linkingAgentIdentifier/oxns:linkingAgentRole")
  end

  def self.xml_template
    Nokogiri::XML::Document.parse(File.new(File.join(File.dirname(__FILE__),'..', '..', '..', 'lib/medusa/default_datastream', "premis_right.xml")))
  end

  def self.right_StatementIdentifier_template
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.right_StatementIdentifierType
      xml.right_StatementIdentifierValue
    end
    return builder.doc.root
  end

  # Inserts a new right_StatementIdentifier node into the premis rights
  def insert_right_StatementIdentifier(opts={})
    node = PremisRightDatastream.right_StatementIdentifier_template
    nodeset = self.find_by_terms(:right_StatementIdentifier)

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
