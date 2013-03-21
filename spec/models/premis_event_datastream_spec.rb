require 'spec_helper'

describe PremisEventDatastream do
   describe "with new datastream" do
      before do
         @datastream = PremisEventDatastream.new(nil,'edescMetadata')
      end
      it "should have event_identifier" do
         test_attribute_xpath(@datastream, 'event_identifier', "//oxns:eventIdentifier")
      end
      it "should have event_identifierType" do
         test_attribute_xpath(@datastream, 'event_identifierType', "//oxns:eventIdentifier/oxns:eventIdentifierType")
      end
      it "should have event_identifierValue" do
         test_attribute_xpath(@datastream, 'event_identifierValue', "//oxns:eventIdentifier/oxns:eventIdentifierValue")
      end

      it "should have event_type" do
         test_attribute_xpath(@datastream, 'event_type', "//oxns:eventType")
      end
      it "should have event_DateTime" do
         test_attribute_xpath(@datastream, 'event_DateTime', "//oxns:eventDateTime")
      end
      it "should have event_detail" do
         test_attribute_xpath(@datastream, 'event_detail', "//oxns:eventDetail")
      end

      it "should have event_linkingAgentIdentifier" do
         test_attribute_xpath(@datastream, 'event_linkingAgentIdentifier', "//oxns:linkingAgentIdentifier")
      end
      it "should have event_linkingAgentIdentifierType" do
         test_attribute_xpath(@datastream, 'event_linkingAgentIdentifierType', "//oxns:linkingAgentIdentifier/oxns:linkingAgentIdentifierType")
      end
      it "should have event_linkingAgentIdentifierValue" do
         test_attribute_xpath(@datastream, 'event_linkingAgentIdentifierValue', "//oxns:linkingAgentIdentifier/oxns:linkingAgentIdentifierValue")
      end
      it "should have event_linkingAgentRole" do
         test_attribute_xpath(@datastream, 'event_linkingAgentRole', "//oxns:linkingAgentIdentifier/oxns:linkingAgentRole")
      end

      it "should have event_linkingObjectIdentifier" do
         test_attribute_xpath(@datastream, 'event_linkingObjectIdentifier', "//oxns:linkingObjectIdentifier")
      end
      it "should have event_linkingObjectIdentifierType" do
         test_attribute_xpath(@datastream, 'event_linkingObjectIdentifierType', "//oxns:linkingObjectIdentifier/oxns:linkingObjectIdentifierType")
      end
      it "should have event_linkingObjectIdentifierValue" do
         test_attribute_xpath(@datastream, 'event_linkingObjectIdentifierValue', "//oxns:linkingObjectIdentifier/oxns:linkingObjectIdentifierValue")
      end
      it "should have event_linkingObjectRole" do
         test_attribute_xpath(@datastream, 'event_linkingObjectRole', "//oxns:linkingObjectIdentifier/oxns:linkingObjectRole")
      end

      it "should have event_outcomeInformation" do
         test_attribute_xpath(@datastream, 'event_outcomeInformation', "//oxns:eventOutcomeInformation")
      end
      it "should have event_outcome" do
         test_attribute_xpath(@datastream, 'event_outcome', "//oxns:eventOutcomeInformation/oxns:eventOutcome")
      end
      it "should have event_outcomeDetail" do
         test_attribute_xpath(@datastream, 'event_outcomeDetail', "//oxns:eventOutcomeInformation/oxns:eventOutcomeDetail")
      end
      it "should have event_outcomeDetailNote" do
         test_attribute_xpath(@datastream, 'event_outcomeDetailNote', "//oxns:eventOutcomeInformation/oxns:eventOutcomeDetail/oxns:eventOutcomeDetailNote")
      end
      it "should have event_outcomeDetailExtension" do
         test_attribute_xpath(@datastream, 'event_outcomeDetailExtension', "//oxns:eventOutcomeInformation/oxns:eventOutcomeDetail/oxns:eventOutcomeDetailExtension")
      end
   end

   describe "with existing datastream" do
     before do
       file = File.new(File.join(File.dirname(__FILE__),'..' ,'fixtures', "premis_event_sample.xml"))
       @datastream = PremisEventDatastream.from_xml(file)
     end

     it "should have event_identifierType" do
         test_existing_attribute(@datastream, 'event_identifierType', 'LOCAL')
     end
     it "should have event_identifierValue" do
         test_existing_attribute(@datastream, 'event_identifierValue', '12345')
     end
     it "should have event_type" do
         test_existing_attribute(@datastream, 'event_type', 'validation')
     end
     it "should have event_DateTime" do
         test_existing_attribute(@datastream, 'event_DateTime', '2013-01-01T15:45:00')
     end

     it "should have event_detail" do
         test_existing_attribute(@datastream, 'event_detail', 'jhove')
     end

     it "should have multiple event_linkingAgentIdentifierType" do
        test_existing_attribute_multiple_occurence(@datastream, 'event_linkingAgentIdentifierType', ['LOCAL', 'MACHINE'])
     end
     it "should have multiple event_linkingAgentIdentifierValue" do
        test_existing_attribute_multiple_occurence(@datastream, 'event_linkingAgentIdentifierValue', ['smith', 'smith_machine'])
     end
     it "should have multiple event_linkingAgentRole" do
        test_existing_attribute_multiple_occurence(@datastream, 'event_linkingAgentRole', ['primary', 'secondary'])
     end

     it "should have multiple event_linkingObjectIdentifierType" do
        test_existing_attribute_multiple_occurence(@datastream, 'event_linkingObjectIdentifierType', ['LOCAL', 'LOCAL', 'LOCAL'])
     end
     it "should have multiple event_linkingObjectIdentifierValue" do
        test_existing_attribute_multiple_occurence(@datastream, 'event_linkingObjectIdentifierValue', ['MEDUSA_object_a', 'MEDUSA_object_b', 'MEDUSA_object_c'])
     end
     it "should have multiple event_linkingObjectRole" do
        test_existing_attribute_multiple_occurence(@datastream, 'event_linkingObjectRole', ['parent', 'child', 'child'])
     end

     it "should have event_outcome" do
         test_existing_attribute(@datastream, 'event_outcome', 'successful')
     end
     it "should have event_outcomeDetailNote" do
         test_existing_attribute(@datastream, 'event_outcomeDetailNote', 'well-formed and valid record')
     end
     it "should have event_outcomeDetailExtension" do
         test_existing_attribute(@datastream, 'event_outcomeDetailExtension', '')
     end

     describe "insert event_linkingAgentIdentifier node into existing premis event" do
       it "should work when all sub-tag values of event_linkingAgentIdentifier are provided" do
         @datastream.insert_event_linkingAgentIdentifier(:event_linkingAgentIdentifierType=>"2_TEST", :event_linkingAgentIdentifierValue=>"2_test_value_here", :event_linkingAgentRole=>"2_test_role_here")
         test_existing_attribute_multiple_occurence(@datastream,  'event_linkingAgentIdentifierType', ['LOCAL', 'MACHINE', '2_TEST'])
         test_existing_attribute_multiple_occurence(@datastream,  'event_linkingAgentIdentifierValue', ['smith', 'smith_machine', '2_test_value_here'])
         test_existing_attribute_multiple_occurence(@datastream,  'event_linkingAgentRole', ['primary', 'secondary', '2_test_role_here'])
       end
     end 
   end
end

