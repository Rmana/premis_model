class PremisContainerDatastream < ActiveFedora::NokogiriDatastream
  set_terminology do |t|
    t.root(:path=>'premis', :xmlns=>'info:lc/xmlns/premis-v2', "xmlns:xsi"=>"http://www.w3.org/2001/XMLSchema-instance", :schema=>"http://www.loc.gov/standards/premis/v2/premis-v2-2.xsd")

    # Premis Object
    t.object_premis(:path=>"object[@xsi:type]") 

    # Premis Agent
    t.agent_premis(:path=>"agent") 
  end

  # Template is loaded from lib/bibl-default.premis_file.xml
  def self.xml_template
    Nokogiri::XML::Document.parse(File.new(File.join(File.dirname(__FILE__),'..', '..', '..', 'lib/medusa/default_datastream', "premis_container.xml")))
  end

end
