require 'spec_helper'

describe PremisFolderObjectDatastream do
   describe "with new datastream" do
      before do
         @datastream = PremisFolderObjectDatastream.new(nil,'folodescMetadata')
      end
      it "should have object_folder_identifier" do
         test_attribute_xpath(@datastream, 'object_folder_identifier', "//oxns:object[@xsi:type='representation']/oxns:objectIdentifier")
      end
      it "should have object_folder_identifierType" do
         test_attribute_xpath(@datastream, 'object_folder_identifierType', "//oxns:object[@xsi:type='representation']/oxns:objectIdentifier/oxns:objectIdentifierType")
      end
      it "should have object_folder_identifierValue" do
         test_attribute_xpath(@datastream, 'object_folder_identifierValue', "//oxns:object[@xsi:type='representation']/oxns:objectIdentifier/oxns:objectIdentifierValue")
      end

      it "should have object_folder_originalName" do
         test_attribute_xpath(@datastream, 'object_folder_originalName', "//oxns:object[@xsi:type='representation']/oxns:originalName")
      end

      it "should have object_folder_preservationLevelValue" do
         test_attribute_xpath(@datastream, 'object_folder_preservationLevelValue', "//oxns:object[@xsi:type='representation']/oxns:preservationLevel/oxns:preservationLevelValue")
      end
      it "should have object_folder_preservationLevelRationale" do
         test_attribute_xpath(@datastream, 'object_folder_preservationLevelRationale', "//oxns:object[@xsi:type='representation']/oxns:preservationLevel/oxns:preservationLevelRationale")
      end
      it "should have object_folder_preservationLevelDateAssigned" do
         test_attribute_xpath(@datastream, 'object_folder_preservationLevelDateAssigned', "//oxns:object[@xsi:type='representation']/oxns:preservationLevel/oxns:preservationLevelDateAssigned")
      end

      it "should have object_folder_linkingEventIdentifierType" do
         test_attribute_xpath(@datastream, 'object_folder_linkingEventIdentifierType', "//oxns:object[@xsi:type='representation']/oxns:linkingEventIdentifier/oxns:linkingEventIdentifierType")
      end
      it "should have object_folder_linkingEventIdentifierValue" do
         test_attribute_xpath(@datastream, 'object_folder_linkingEventIdentifierValue', "//oxns:object[@xsi:type='representation']/oxns:linkingEventIdentifier/oxns:linkingEventIdentifierValue")
      end

      it "should have object_folder_linkingIntellectualEntityIdentifierType" do
         test_attribute_xpath(@datastream, 'object_folder_linkingIntellectualEntityIdentifierType', "//oxns:object[@xsi:type='representation']/oxns:linkingIntellectualEntityIdentifier/oxns:linkingIntellectualEntityIdentifierType")
      end
      it "should have object_folder_linkingIntellectualEntityIdentifierValue" do
         test_attribute_xpath(@datastream, 'object_folder_linkingIntellectualEntityIdentifierValue', "//oxns:object[@xsi:type='representation']/oxns:linkingIntellectualEntityIdentifier/oxns:linkingIntellectualEntityIdentifierValue")
      end

      it "should have object_folder_linkingRightsStatementIdentifierType" do
         test_attribute_xpath(@datastream, 'object_folder_linkingRightsStatementIdentifierType', "//oxns:object[@xsi:type='representation']/oxns:linkingRightsStatementIdentifier/oxns:linkingRightsStatementIdentifierType")
      end
      it "should have object_folder_linkingRightsStatementIdentifierValue" do
         test_attribute_xpath(@datastream, 'object_folder_linkingRightsStatementIdentifierValue', "//oxns:object[@xsi:type='representation']/oxns:linkingRightsStatementIdentifier/oxns:linkingRightsStatementIdentifierValue")
      end

      it "should have object_folder_relationshipType" do
         test_attribute_xpath(@datastream, 'object_folder_relationshipType', "//oxns:object[@xsi:type='representation']/oxns:relationship/oxns:relationshipType")
      end
      it "should have object_folder_relationshipSubType" do
         test_attribute_xpath(@datastream, 'object_folder_relationshipSubType', "//oxns:object[@xsi:type='representation']/oxns:relationship/oxns:relationshipSubType")
      end
      it "should have object_folder_relatedObjectIdentifierType" do
         test_attribute_xpath(@datastream, 'object_folder_relatedObjectIdentifierType', "//oxns:object[@xsi:type='representation']/oxns:relationship/oxns:relatedObjectIdentification/oxns:relatedObjectIdentifierType")
      end
      it "should have object_folder_relatedObjectIdentifierValue" do
         test_attribute_xpath(@datastream, 'object_folder_relatedObjectIdentifierValue', "//oxns:object[@xsi:type='representation']/oxns:relationship/oxns:relatedObjectIdentification/oxns:relatedObjectIdentifierValue")
      end

   end

   describe "with existing datastream" do
     before do
       file = File.new(File.join(File.dirname(__FILE__),'..' ,'fixtures', "premis_folder_object_sample.xml"))
       @datastream = PremisFolderObjectDatastream.from_xml(file)
     end

     it "should have first occurence of object_folder_identifierType" do
        test_existing_attribute_nth_occurence(@datastream, 1, 'object_folder_identifierType', "local")
     end
     it "should have multiple object_folder_identifierType" do
        test_existing_attribute_multiple_occurence(@datastream, 'object_folder_identifierType', ['local', 'HANDLE'])
     end
     it "should have multiple object_folder_identifierValue" do
        test_existing_attribute_multiple_occurence(@datastream, 'object_folder_identifierValue', ['lab', '10111/MEDUSA:xxx'])
     end

     it "should have object_folder_originalName" do
         test_existing_attribute(@datastream, 'object_folder_originalName', '\\\\machine_name\\original_name')
     end

     it "should have object_folder_preservationLevelValue" do
         test_existing_attribute(@datastream, 'object_folder_preservationLevelValue', 'BIT_LEVEL')
     end
     it "should have object_folder_preservationLevelRationale" do
         test_existing_attribute(@datastream, 'object_folder_preservationLevelRationale', 'Uncategorized file system capture')
     end
     it "should have object_folder_preservationLevelDateAssigned" do
         test_existing_attribute(@datastream, 'object_folder_preservationLevelDateAssigned', '2012-01-01T14:41:03')
     end

     it "should have multiple object_folder_relationshipType" do
        test_existing_attribute_multiple_occurence(@datastream, 'object_folder_relationshipType', ['BASIC_COMPOUND_ASSET', 'BASIC_COMPOUND_ASSET'])
     end
     it "should have multiple object_folder_relationshipSubType" do
        test_existing_attribute_multiple_occurence(@datastream, 'object_folder_relationshipSubType', ['CHILD', 'CHILD'])
     end
     it "should have multiple object_folder_relatedObjectIdentifierType" do
        test_existing_attribute_multiple_occurence(@datastream, 'object_folder_relatedObjectIdentifierType', ['LOCAL', 'LOCAL'])
     end
     it "should have multiple object_folder_relatedObjectIdentifierValue" do
        test_existing_attribute_multiple_occurence(@datastream, 'object_folder_relatedObjectIdentifierValue', ['local_identifier_one', 'local_identifier_two'])
     end

     it "should have object_folder_linkingEventIdentifierType" do
         test_existing_attribute(@datastream, 'object_folder_linkingEventIdentifierType', 'LOCAL')
     end
     it "should have object_folder_linkingEventIdentifierValue" do
         test_existing_attribute(@datastream, 'object_folder_linkingEventIdentifierValue', 'local_linking_event_one')
     end
     it "should have object_folder_linkingRightsStatementIdentifierType" do
         test_existing_attribute(@datastream, 'object_folder_linkingRightsStatementIdentifierType', 'LOCAL')
     end
     it "should have object_folder_linkingRightsStatementIdentifierValue" do
         test_existing_attribute(@datastream, 'object_folder_linkingRightsStatementIdentifierValue', 'local_rights_statement_one')
     end
     it "should have object_folder_linkingIntellectualEntityIdentifierType" do
         test_existing_attribute(@datastream, 'object_folder_linkingIntellectualEntityIdentifierType', 'LOCAL')
     end
     it "should have object_folder_linkingIntellectualEntityIdentifierValue" do
         test_existing_attribute(@datastream, 'object_folder_linkingIntellectualEntityIdentifierValue', 'local_intellectual_entity_statement_one')
     end

     describe "insert object_folder_identifier node into existing premis folder object" do
       it "should work when BOTH values of object_folder_identifierType & object_folder_identifierValue are provided" do
         @datastream.insert_object_folder_identifier(:object_folder_identifierType=>"3_TEST", :object_folder_identifierValue=>"3_test_value_here")
         test_existing_attribute_nth_occurence(@datastream, 3, 'object_folder_identifierType', "3_TEST")
         test_existing_attribute_nth_occurence(@datastream, 3, 'object_folder_identifierValue', "3_test_value_here")
       end
       it "should work when ONLY value of object_folder_identifierType is provided" do
         @datastream.insert_object_folder_identifier(:object_folder_identifierType=>"4_TEST")
         test_existing_attribute_nth_occurence(@datastream, 3, 'object_folder_identifierType', "4_TEST")
         test_existing_attribute_nth_occurence(@datastream, 3, 'object_folder_identifierValue', "")
       end
       it "should work when ONLY value of object_folder_identifierValue is provided" do
         @datastream.insert_object_folder_identifier(:object_folder_identifierValue=>"5_test_value_here")
         test_existing_attribute_nth_occurence(@datastream, 3, 'object_folder_identifierType', "")
         test_existing_attribute_nth_occurence(@datastream, 3, 'object_folder_identifierValue', "5_test_value_here")
       end
       it "should work when NEITHER values of object_folder_identifierType & object_folder_identifierValue are provided" do
         @datastream.insert_object_folder_identifier
         test_existing_attribute_nth_occurence(@datastream, 3, 'object_folder_identifierType', "")
         test_existing_attribute_nth_occurence(@datastream, 3, 'object_folder_identifierValue', "")
       end
     end 
   end
end

