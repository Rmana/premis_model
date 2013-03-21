require 'spec_helper'

describe PremisRightDatastream do
   describe "with new datastream" do
      before do
         @datastream = PremisRightDatastream.new(nil,'rdescMetadata')
      end
      it "should have right_StatementIdentifier" do
         test_attribute_xpath(@datastream, 'right_StatementIdentifier', "//oxns:rightsStatement/oxns:rightsStatementIdentifier")
      end
      it "should have right_StatementIdentifierType" do
         test_attribute_xpath(@datastream, 'right_StatementIdentifierType', "//oxns:rightsStatement/oxns:rightsStatementIdentifier/oxns:rightsStatementIdentifierType")
      end
      it "should have right_StatementIdentifierValue" do
         test_attribute_xpath(@datastream, 'right_StatementIdentifierValue', "//oxns:rightsStatement/oxns:rightsStatementIdentifier/oxns:rightsStatementIdentifierValue")
      end

      it "should have right_Basis" do
         test_attribute_xpath(@datastream, 'right_Basis', "//oxns:rightsStatement/oxns:rightsBasis")
      end

      it "should have right_copyrightInformation" do
         test_attribute_xpath(@datastream, 'right_copyrightInformation', "//oxns:rightsStatement/oxns:copyrightInformation")
      end
      it "should have right_copyrightStatus" do
         test_attribute_xpath(@datastream, 'right_copyrightStatus', "//oxns:rightsStatement/oxns:copyrightInformation/oxns:copyrightStatus")
      end
      it "should have right_copyrightJurisdiction" do
         test_attribute_xpath(@datastream, 'right_copyrightJurisdiction', "//oxns:rightsStatement/oxns:copyrightInformation/oxns:copyrightJurisdiction")
      end

      it "should have right_Granted" do
         test_attribute_xpath(@datastream, 'right_Granted', "//oxns:rightsStatement/oxns:rightsGranted")
      end
      it "should have right_linkingObjectIdentifierType_GrantedAct" do
         test_attribute_xpath(@datastream, 'right_linkingObjectIdentifierType_GrantedAct', "//oxns:rightsStatement/oxns:rightsGranted/oxns:act")
      end
      it "should have right_GrantedRestriction" do
         test_attribute_xpath(@datastream, 'right_GrantedRestriction', "//oxns:rightsStatement/oxns:rightsGranted/oxns:restriction")
      end

      it "should have right_linkingObjectIdentifier" do
         test_attribute_xpath(@datastream, 'right_linkingObjectIdentifier', "//oxns:rightsStatement/oxns:linkingObjectIdentifier")
      end
      it "should have right_linkingObjectIdentifierType" do
         test_attribute_xpath(@datastream, 'right_linkingObjectIdentifierType', "//oxns:rightsStatement/oxns:linkingObjectIdentifier/oxns:linkingObjectIdentifierType")
      end
      it "should have right_linkingObjectIdentifierValue" do
         test_attribute_xpath(@datastream, 'right_linkingObjectIdentifierValue', "//oxns:rightsStatement/oxns:linkingObjectIdentifier/oxns:linkingObjectIdentifierValue")
      end
      it "should have right_linkingObjectRole" do
         test_attribute_xpath(@datastream, 'right_linkingObjectRole', "//oxns:rightsStatement/oxns:linkingObjectIdentifier/oxns:linkingObjectRole")
      end

      it "should have right_linkingAgentIdentifier" do
         test_attribute_xpath(@datastream, 'right_linkingAgentIdentifier', "//oxns:rightsStatement/oxns:linkingAgentIdentifier")
      end
      it "should have right_linkingAgentIdentifierType" do
         test_attribute_xpath(@datastream, 'right_linkingAgentIdentifierType', "//oxns:rightsStatement/oxns:linkingAgentIdentifier/oxns:linkingAgentIdentifierType")
      end
      it "should have right_linkingAgentIdentifierValue" do
         test_attribute_xpath(@datastream, 'right_linkingAgentIdentifierValue', "//oxns:rightsStatement/oxns:linkingAgentIdentifier/oxns:linkingAgentIdentifierValue")
      end
      it "should have right_linkingAgentRole" do
         test_attribute_xpath(@datastream, 'right_linkingAgentRole', "//oxns:rightsStatement/oxns:linkingAgentIdentifier/oxns:linkingAgentRole")
      end
   end

   describe "with existing datastream" do
     before do
       file = File.new(File.join(File.dirname(__FILE__),'..' ,'fixtures', "premis_right_sample.xml"))
       @datastream = PremisRightDatastream.from_xml(file)
     end

     it "should have first occurence of right_StatementIdentifierType" do
        test_existing_attribute_nth_occurence(@datastream, 1, 'right_StatementIdentifierType', "LOCAL")
     end
     it "should have first occurence of right_StatementIdentifierValue" do
        test_existing_attribute_nth_occurence(@datastream, 1, 'right_StatementIdentifierValue', "local_identifier_for_rights_one")
     end

     it "should have right_Basis" do
        test_existing_attribute(@datastream, 'right_Basis', 'COPYRIGHT')
     end
     it "should have right_copyrightStatus" do
        test_existing_attribute(@datastream, 'right_copyrightStatus', 'IN_COPYRIGHT')
     end
     it "should have right_copyrightJurisdiction" do
        test_existing_attribute(@datastream, 'right_copyrightJurisdiction', 'United States')
     end
     it "should have right_linkingObjectIdentifierType_GrantedAct" do
        test_existing_attribute(@datastream, 'right_linkingObjectIdentifierType_GrantedAct', 'DISSEMINATE')
     end
     it "should have right_GrantedRestriction" do
        test_existing_attribute(@datastream, 'right_GrantedRestriction', 'CAMPUS_ONLY')
     end

     it "should have right_linkingObjectIdentifierType" do
        test_existing_attribute(@datastream, 'right_linkingObjectIdentifierType', 'LOCAL')
     end
     it "should have right_linkingObjectIdentifierValue" do
        test_existing_attribute(@datastream, 'right_linkingObjectIdentifierValue', 'local_linked_object_one')
     end
     it "should have right_linkingObjectRole" do
        test_existing_attribute(@datastream, 'right_linkingObjectRole', '')
     end

     describe "insert right_StatementIdentifier node into existing premis right" do
       it "should work when BOTH values of right_StatementIdentifierType & right_StatementIdentifierValue are provided" do
         @datastream.insert_right_StatementIdentifier(:right_StatementIdentifierType=>"5_TEST", :right_StatementIdentifierValue=>"5_test_value_here")
         test_existing_attribute_nth_occurence(@datastream, 2, 'right_StatementIdentifierType', "5_TEST")
         test_existing_attribute_nth_occurence(@datastream, 2, 'right_StatementIdentifierValue', "5_test_value_here")
       end
       it "should work when ONLY value of right_StatementIdentifierType is provided" do
         @datastream.insert_right_StatementIdentifier(:right_StatementIdentifierType=>"6_TEST")
         test_existing_attribute_nth_occurence(@datastream, 2, 'right_StatementIdentifierType', "6_TEST")
         test_existing_attribute_nth_occurence(@datastream, 2, 'right_StatementIdentifierValue', "")
       end
       it "should work when ONLY value of right_StatementIdentifierValue is provided" do
         @datastream.insert_right_StatementIdentifier(:right_StatementIdentifierValue=>"7_test_value_here")
         test_existing_attribute_nth_occurence(@datastream, 2, 'right_StatementIdentifierType', "")
         test_existing_attribute_nth_occurence(@datastream, 2, 'right_StatementIdentifierValue', "7_test_value_here")
       end
       it "should work when NEITHER values of right_StatementIdentifierType & right_StatementIdentifierValue are provided" do
         @datastream.insert_right_StatementIdentifier
         test_existing_attribute_nth_occurence(@datastream, 2, 'right_StatementIdentifierType', "")
         test_existing_attribute_nth_occurence(@datastream, 2, 'right_StatementIdentifierValue', "")
       end
     end 
   end
end

