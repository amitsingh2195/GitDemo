@istest
public class MPeamble_UserLicenseControllerTest {
    
    public static testMethod void testController(){
        //List<Fcias__MPreambleLog__c> UserLi = new List<Fcias__MPreambleLog__c>();
        
        Fcias__MPreambleLog__c MP = new Fcias__MPreambleLog__c();
        MP.Fcias__Salesforce_License_Name__c = 'TestLi';
        MP.Fcias__Salesforce_Licenses_Id__c = '12';
        MP.Fcias__Salesforce_Used_Licenses__c = 3;
        MP.Fcias__Salesforce_Total_Licenses__c =4;
        insert MP;
        
        Test.startTest();
        MPreamble_UserLicenseController testLicense = new MPreamble_UserLicenseController();
        testLicense.getLicenses();
        Test.stopTest();
    }

}