@isTest
public class MPreamble_UserLicensesTest {
    
    public static testMethod void TestUserLicenses(){
        
        Fcias__MPreambleLog__c MP = new Fcias__MPreambleLog__c();
        MP.Fcias__Salesforce_Licenses_Id__c= 'asdsa';
        MP.Fcias__Salesforce_License_Name__c = 'dsakdk';
        MP.Fcias__Salesforce_Used_Licenses__c = 5;
        MP.Fcias__Salesforce_Total_Licenses__c = 10;
        insert MP;
        
        Test.startTest();
        
        MPreamble_UserLicenses.UserLicense();
        
        Test.stopTest();
        
        
    }

}