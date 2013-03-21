require 'spec_helper'

describe PremisAgentDatastream do
   describe "with new datastream" do
      before do
         @datastream = PremisAgentDatastream.new(nil,'adescMetadata')
      end
      it "should have agent_identifier" do
         test_attribute_xpath(@datastream, 'agent_identifier', "//oxns:agentIdentifier")
      end
      it "should have agent_identifierType" do
         test_attribute_xpath(@datastream, 'agent_identifierType', "//oxns:agentIdentifier/oxns:agentIdentifierType")
      end
      it "should have agent_identifierValue" do
         test_attribute_xpath(@datastream, 'agent_identifierValue', "//oxns:agentIdentifier/oxns:agentIdentifierValue")
      end

      it "should have agent_name" do
         test_attribute_xpath(@datastream, 'agent_name', "//oxns:agentName")
      end
      it "should have agent_note" do
         test_attribute_xpath(@datastream, 'agent_note', "//oxns:agentNote")
      end
      it "should have agent_extension" do
         test_attribute_xpath(@datastream, 'agent_extension', "//oxns:agentExtension")
      end
      it "should have agent_type" do
         test_attribute_xpath(@datastream, 'agent_type', "//oxns:agentType")
      end

      it "should have agent_linkingEventIdentifier" do
         test_attribute_xpath(@datastream, 'agent_linkingEventIdentifier', "//oxns:linkingEventIdentifier")
      end
      it "should have agent_linkingEventIdentifierType" do
         test_attribute_xpath(@datastream, 'agent_linkingEventIdentifierType', "//oxns:linkingEventIdentifier/oxns:linkingEventIdentifierType")
      end
      it "should have agent_linkingEventIdentifierValue" do
         test_attribute_xpath(@datastream, 'agent_linkingEventIdentifierValue', "//oxns:linkingEventIdentifier/oxns:linkingEventIdentifierValue")
      end

      it "should have agent_linkingRightsStatementIdentifier" do
         test_attribute_xpath(@datastream, 'agent_linkingRightsStatementIdentifier', "//oxns:linkingRightsStatementIdentifier")
      end
      it "should have agent_linkingRightsStatementIdentifierType" do
         test_attribute_xpath(@datastream, 'agent_linkingRightsStatementIdentifierType', "//oxns:linkingRightsStatementIdentifier/oxns:linkingRightsStatementIdentifierType")
      end
      it "should have agent_linkingRightsStatementIdentifierValue" do
         test_attribute_xpath(@datastream, 'agent_linkingRightsStatementIdentifierValue', "//oxns:linkingRightsStatementIdentifier/oxns:linkingRightsStatementIdentifierValue")
      end

   end

   describe "with existing datastream" do
     before do
       file = File.new(File.join(File.dirname(__FILE__),'..' ,'fixtures', "premis_agent_sample.xml"))
       @datastream = PremisAgentDatastream.from_xml(file)
     end

     it "should have first occurence of agent_identifierType" do
        test_existing_attribute_nth_occurence(@datastream, 1, 'agent_identifierType', "LOCAL")
     end
     it "should have multiple agent_identifierType" do
        test_existing_attribute_multiple_occurence(@datastream, 'agent_identifierType', ['LOCAL', 'UIUC NETID', 'EMAIL', 'SOFTWARE_VERSION'])
     end
     it "should have multiple agent_identifierValue" do
        test_existing_attribute_multiple_occurence(@datastream, 'agent_identifierValue', ['MEDUSA:1581d4a9-c6a0-4b69-b2d1-969f4a36208a-1', 'UIUC\name_here', 'First_name Last_name', 'FolderPackager 1.0.0.0'])
     end

     it "should have agent_type" do
         test_existing_attribute(@datastream, 'agent_type', 'SOFTWARE')
     end
     it "should have agent_name" do
         test_existing_attribute(@datastream, 'agent_name', 'FolderPackager 1.0.0.0 [Library, University of Illinois at Urbana-Champaign]')
     end
     it "should have first occurence of agent_note" do
        test_existing_attribute_nth_occurence(@datastream, 1, 'agent_note', "Run on Computer: LIBGRLUGH, Microsoft Windows 7 Ultimate V6.1.7601.65536, English (United States)")
     end

     it "should have agent_linkingEventIdentifierType" do
         test_existing_attribute(@datastream, 'agent_linkingEventIdentifierType', 'LC Event ID')
     end
     it "should have agent_linkingEventIdentifierValue" do
         test_existing_attribute(@datastream, 'agent_linkingEventIdentifierValue', 'eID-58f202ac-22cf-11')
     end
     it "should have agent_linkingRightsStatementIdentifierType" do
         test_existing_attribute(@datastream, 'agent_linkingRightsStatementIdentifierType', 'LC Rights ID')
     end
     it "should have agent_linkingRightsStatementIdentifierValue" do
         test_existing_attribute(@datastream, 'agent_linkingRightsStatementIdentifierValue', 'rID-58f202ac-22cf-11')
     end

     describe "insert agent_identifier node into existing premis agent" do
       it "should work when BOTH values of agent_identifierType & agent_identifierValue are provided" do
         @datastream.insert_agent_identifier(:agent_identifierType=>"5_TEST", :agent_identifierValue=>"5_test_value_here")
         test_existing_attribute_nth_occurence(@datastream, 5, 'agent_identifierType', "5_TEST")
         test_existing_attribute_nth_occurence(@datastream, 5, 'agent_identifierValue', "5_test_value_here")
       end
       it "should work when ONLY value of agent_identifierType is provided" do
         @datastream.insert_agent_identifier(:agent_identifierType=>"6_TEST")
         test_existing_attribute_nth_occurence(@datastream, 5, 'agent_identifierType', "6_TEST")
         test_existing_attribute_nth_occurence(@datastream, 5, 'agent_identifierValue', "")
       end
       it "should work when ONLY value of agent_identifierValue is provided" do
         @datastream.insert_agent_identifier(:agent_identifierValue=>"7_test_value_here")
         test_existing_attribute_nth_occurence(@datastream, 5, 'agent_identifierType', "")
         test_existing_attribute_nth_occurence(@datastream, 5, 'agent_identifierValue', "7_test_value_here")
       end
       it "should work when NEITHER values of agent_identifierType & agent_identifierValue are provided" do
         @datastream.insert_agent_identifier
         test_existing_attribute_nth_occurence(@datastream, 5, 'agent_identifierType', "")
         test_existing_attribute_nth_occurence(@datastream, 5, 'agent_identifierValue', "")
       end
     end 
   end
end

