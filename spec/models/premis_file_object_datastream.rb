require 'spec_helper'

describe PremisFileObjectDatastream do
   describe "with new datastream" do
      before do
         @datastream = PremisFileObjectDatastream.new(nil,'fodescMetadata')
      end
      it "should have object_file_identifier" do
         test_attribute_xpath(@datastream, 'object_file_identifier', "//oxns:object[@xsi:type='file']/oxns:objectIdentifier")
      end
      it "should have object_file_identifierType" do
         test_attribute_xpath(@datastream, 'object_file_identifierType', "//oxns:object[@xsi:type='file']/oxns:objectIdentifier/oxns:objectIdentifierType")
      end
      it "should have object_file_identifierValue" do
         test_attribute_xpath(@datastream, 'object_file_identifierValue', "//oxns:object[@xsi:type='file']/oxns:objectIdentifier/oxns:objectIdentifierValue")
      end

      it "should have object_file_characteristics_CompositionLevel" do
         test_attribute_xpath(@datastream, 'object_file_characteristics_CompositionLevel', "//oxns:object[@xsi:type='file']/oxns:objectCharacteristics/oxns:compositionLevel")
      end
      it "should have object_file_characteristics_fixitymessageDigestAlgorithm" do
         test_attribute_xpath(@datastream, 'object_file_characteristics_fixitymessageDigestAlgorithm', "//oxns:object[@xsi:type='file']/oxns:objectCharacteristics/oxns:fixity/oxns:messageDigestAlgorithm")
      end
      it "should have object_file_characteristics_fixitymessageDigest" do
         test_attribute_xpath(@datastream, 'object_file_characteristics_fixitymessageDigest', "//oxns:object[@xsi:type='file']/oxns:objectCharacteristics/oxns:fixity/oxns:messageDigest")
      end
      it "should have object_file_characteristics_fixitymessageDigestOriginator" do
         test_attribute_xpath(@datastream, 'object_file_characteristics_fixitymessageDigestOriginator', "//oxns:object[@xsi:type='file']/oxns:objectCharacteristics/oxns:fixity/oxns:messageDigestOriginator")
      end
      it "should have object_file_characteristics_size" do
         test_attribute_xpath(@datastream, 'object_file_characteristics_size', "//oxns:object[@xsi:type='file']/oxns:objectCharacteristics/oxns:size")
      end
      it "should have object_file_characteristics_formatName" do
         test_attribute_xpath(@datastream, 'object_file_characteristics_formatName', "//oxns:object[@xsi:type='file']/oxns:objectCharacteristics/oxns:format/oxns:formatDesignation/oxns:formatName")
      end
      it "should have object_file_characteristics_formatVersion" do
         test_attribute_xpath(@datastream, 'object_file_characteristics_formatVersion', "//oxns:object[@xsi:type='file']/oxns:objectCharacteristics/oxns:format/oxns:formatDesignation/oxns:formatVersion")
      end
      it "should have object_file_characteristics_formatRegistryName" do
         test_attribute_xpath(@datastream, 'object_file_characteristics_formatRegistryName', "//oxns:object[@xsi:type='file']/oxns:objectCharacteristics/oxns:format/oxns:formatRegistry/oxns:formatRegistryName")
      end
      it "should have object_file_characteristics_formatRegistryKey" do
         test_attribute_xpath(@datastream, 'object_file_characteristics_formatRegistryKey', "//oxns:object[@xsi:type='file']/oxns:objectCharacteristics/oxns:format/oxns:formatRegistry/oxns:formatRegistryKey")
      end
      it "should have object_file_characteristics_formatRegistryRole" do
         test_attribute_xpath(@datastream, 'object_file_characteristics_formatRegistryRole', "//oxns:object[@xsi:type='file']/oxns:objectCharacteristics/oxns:format/oxns:formatRegistry/oxns:formatRegistryRole")
      end
      it "should have object_file_characteristics_creatingApplicationName" do
         test_attribute_xpath(@datastream, 'object_file_characteristics_creatingApplicationName', "//oxns:object[@xsi:type='file']/oxns:objectCharacteristics/oxns:creatingApplication/oxns:creatingApplicationName")
      end
      it "should have object_file_characteristics_creatingApplicationVersion" do
         test_attribute_xpath(@datastream, 'object_file_characteristics_creatingApplicationVersion', "//oxns:object[@xsi:type='file']/oxns:objectCharacteristics/oxns:creatingApplication/oxns:creatingApplicationVersion")
      end
      it "should have object_file_characteristics_dateCreatedByApplication" do
         test_attribute_xpath(@datastream, 'object_file_characteristics_dateCreatedByApplication', "//oxns:object[@xsi:type='file']/oxns:objectCharacteristics/oxns:creatingApplication/oxns:dateCreatedByApplication")
      end

      it "should have object_file_originalName" do
         test_attribute_xpath(@datastream, 'object_file_originalName', "//oxns:object[@xsi:type='file']/oxns:originalName")
      end

      it "should have object_file_preservationLevelValue" do
         test_attribute_xpath(@datastream, 'object_file_preservationLevelValue', "//oxns:object[@xsi:type='file']/oxns:preservationLevel/oxns:preservationLevelValue")
      end
      it "should have object_file_preservationLevelRationale" do
         test_attribute_xpath(@datastream, 'object_file_preservationLevelRationale', "//oxns:object[@xsi:type='file']/oxns:preservationLevel/oxns:preservationLevelRationale")
      end
      it "should have object_file_preservationLevelDateAssigned" do
         test_attribute_xpath(@datastream, 'object_file_preservationLevelDateAssigned', "//oxns:object[@xsi:type='file']/oxns:preservationLevel/oxns:preservationLevelDateAssigned")
      end

      it "should have object_file_linkingEventIdentifierType" do
         test_attribute_xpath(@datastream, 'object_file_linkingEventIdentifierType', "//oxns:object[@xsi:type='file']/oxns:linkingEventIdentifier/oxns:linkingEventIdentifierType")
      end
      it "should have object_file_linkingEventIdentifierValue" do
         test_attribute_xpath(@datastream, 'object_file_linkingEventIdentifierValue', "//oxns:object[@xsi:type='file']/oxns:linkingEventIdentifier/oxns:linkingEventIdentifierValue")
      end

      it "should have object_file_linkingIntellectualEntityIdentifierType" do
         test_attribute_xpath(@datastream, 'object_file_linkingIntellectualEntityIdentifierType', "//oxns:object[@xsi:type='file']/oxns:linkingIntellectualEntityIdentifier/oxns:linkingIntellectualEntityIdentifierType")
      end
      it "should have object_file_linkingIntellectualEntityIdentifierValue" do
         test_attribute_xpath(@datastream, 'object_file_linkingIntellectualEntityIdentifierValue', "//oxns:object[@xsi:type='file']/oxns:linkingIntellectualEntityIdentifier/oxns:linkingIntellectualEntityIdentifierValue")
      end

      it "should have object_file_linkingRightsStatementIdentifierType" do
         test_attribute_xpath(@datastream, 'object_file_linkingRightsStatementIdentifierType', "//oxns:object[@xsi:type='file']/oxns:linkingRightsStatementIdentifier/oxns:linkingRightsStatementIdentifierType")
      end
      it "should have object_file_linkingRightsStatementIdentifierValue" do
         test_attribute_xpath(@datastream, 'object_file_linkingRightsStatementIdentifierValue', "//oxns:object[@xsi:type='file']/oxns:linkingRightsStatementIdentifier/oxns:linkingRightsStatementIdentifierValue")
      end

      it "should have object_file_relationshipType" do
         test_attribute_xpath(@datastream, 'object_file_relationshipType', "//oxns:object[@xsi:type='file']/oxns:relationship/oxns:relationshipType")
      end
      it "should have object_file_relationshipSubType" do
         test_attribute_xpath(@datastream, 'object_file_relationshipSubType', "//oxns:object[@xsi:type='file']/oxns:relationship/oxns:relationshipSubType")
      end
      it "should have object_file_relatedObjectIdentifierType" do
         test_attribute_xpath(@datastream, 'object_file_relatedObjectIdentifierType', "//oxns:object[@xsi:type='file']/oxns:relationship/oxns:relatedObjectIdentification/oxns:relatedObjectIdentifierType")
      end
      it "should have object_file_relatedObjectIdentifierValue" do
         test_attribute_xpath(@datastream, 'object_file_relatedObjectIdentifierValue', "//oxns:object[@xsi:type='file']/oxns:relationship/oxns:relatedObjectIdentification/oxns:relatedObjectIdentifierValue")
      end

   end

   describe "with existing datastream" do
     before do
       file = File.new(File.join(File.dirname(__FILE__),'..' ,'fixtures', "premis_file_object_sample.xml"))
       @datastream = PremisFileObjectDatastream.from_xml(file)
     end

     it "should have first occurence of object_file_identifierType" do
        test_existing_attribute_nth_occurence(@datastream, 1, 'object_file_identifierType', "local")
     end
     it "should have multiple object_file_identifierType" do
        test_existing_attribute_multiple_occurence(@datastream, 'object_file_identifierType', ['local', 'outside_id'])
     end
     it "should have multiple object_file_identifierValue" do
        test_existing_attribute_multiple_occurence(@datastream, 'object_file_identifierValue', ["local_identifier_value_here", "outside_id_value_here"])
     end

     it "should have object_file_originalName" do
         test_existing_attribute(@datastream, 'object_file_originalName', '0001h.tif')
     end

     it "should have object_file_preservationLevelValue" do
         test_existing_attribute(@datastream, 'object_file_preservationLevelValue', 'OBJECT_LEVEL')
     end
     it "should have object_file_preservationLevelRationale" do
         test_existing_attribute(@datastream, 'object_file_preservationLevelRationale', 'Categorized file system capture')
     end
     it "should have object_file_preservationLevelDateAssigned" do
         test_existing_attribute(@datastream, 'object_file_preservationLevelDateAssigned', '2013-01-01T14:41:03')
     end

     it "should have multiple object_file_relationshipType" do
        test_existing_attribute_multiple_occurence(@datastream, 'object_file_relationshipType', ['structural', 'structural', 'derivation'])
     end
     it "should have multiple object_file_relationshipSubType" do
        test_existing_attribute_multiple_occurence(@datastream, 'object_file_relationshipSubType', ['is sibling', 'is sibling', 'is source of'])
     end
     it "should have multiple object_file_relatedObjectIdentifierType" do
        test_existing_attribute_multiple_occurence(@datastream, 'object_file_relatedObjectIdentifierType', ['hdl', 'URI', 'URL'])
     end
     it "should have multiple object_file_relatedObjectIdentifierValue" do
        test_existing_attribute_multiple_occurence(@datastream, 'object_file_relatedObjectIdentifierValue', ['loc.music/gottlieb.09602', 'http://lcweb2.loc.gov/cocoon/ihas/loc.natlib.gottlieb.09601/mets.xml', 'http://lcweb2.loc.gov/natlib/ihas/service/gottlieb/09601/ver01/0001v.jpg'])
     end

     it "should have multiple object_file_linkingEventIdentifierType" do
         test_existing_attribute_multiple_occurence(@datastream, 'object_file_linkingEventIdentifierType', ['Local Repository', 'Local Repository'])
     end
     it "should have multiple object_file_linkingEventIdentifierValue" do
         test_existing_attribute_multiple_occurence(@datastream, 'object_file_linkingEventIdentifierValue', ['E001.1', 'E001.2'])
     end
     it "should have object_file_linkingRightsStatementIdentifierType" do
         test_existing_attribute(@datastream, 'object_file_linkingRightsStatementIdentifierType', 'LOCAL')
     end
     it "should have object_file_linkingRightsStatementIdentifierValue" do
         test_existing_attribute(@datastream, 'object_file_linkingRightsStatementIdentifierValue', 'local_rights_statement_one')
     end
     it "should have multiple object_file_linkingIntellectualEntityIdentifierType" do
         test_existing_attribute_multiple_occurence(@datastream, 'object_file_linkingIntellectualEntityIdentifierType', ['hdl', 'URI'])
     end
     it "should have multiple object_file_linkingIntellectualEntityIdentifierValue" do
         test_existing_attribute_multiple_occurence(@datastream, 'object_file_linkingIntellectualEntityIdentifierValue', ['loc.natlib.gottlieb.09601', 'http://lcweb2.loc.gov/cocoon/ihas/loc.natlib.gottlieb.09601/default.html'])
     end

     describe "insert object_file_identifier node into existing premis folder object" do
       it "should work when BOTH values of object_file_identifierType & object_file_identifierValue are provided" do
         @datastream.insert_object_file_identifier(:object_file_identifierType=>"3_TEST", :object_file_identifierValue=>"3_test_value_here")
         test_existing_attribute_nth_occurence(@datastream, 3, 'object_file_identifierType', "3_TEST")
         test_existing_attribute_nth_occurence(@datastream, 3, 'object_file_identifierValue', "3_test_value_here")
       end
       it "should work when ONLY value of object_file_identifierType is provided" do
         @datastream.insert_object_file_identifier(:object_file_identifierType=>"4_TEST")
         test_existing_attribute_nth_occurence(@datastream, 3, 'object_file_identifierType', "4_TEST")
         test_existing_attribute_nth_occurence(@datastream, 3, 'object_file_identifierValue', "")
       end
       it "should work when ONLY value of object_file_identifierValue is provided" do
         @datastream.insert_object_file_identifier(:object_file_identifierValue=>"5_test_value_here")
         test_existing_attribute_nth_occurence(@datastream, 3, 'object_file_identifierType', "")
         test_existing_attribute_nth_occurence(@datastream, 3, 'object_file_identifierValue', "5_test_value_here")
       end
       it "should work when NEITHER values of object_file_identifierType & object_file_identifierValue are provided" do
         @datastream.insert_object_file_identifier
         test_existing_attribute_nth_occurence(@datastream, 3, 'object_file_identifierType', "")
         test_existing_attribute_nth_occurence(@datastream, 3, 'object_file_identifierValue', "")
       end
     end 
   end
end

