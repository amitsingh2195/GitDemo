@istest
public class MPreamble_UserTabTest {
    
    public static testMethod void testController()
    {
        Fcias__MPreambleLog__c MP = new Fcias__MPreambleLog__c();
        MP.Fcias__User_Name__c = 'TestName';
        MP.Fcias__Failed_Login_Count__c = 3;
        MP.Fcias__Salesforce_License_Name__c = 'Test1';
        MP.Fcias__Salesforce_Licenses_Id__c = 'Test2';
        MP.Fcias__Salesforce_Total_Licenses__c = 2;
        MP.Fcias__Salesforce_Used_Licenses__c = 4;
        MP.Fcias__User_Id__c = 'ABC';
        
        insert MP;
        
        Test.startTest();
        MPreamble_UserTab UT = new MPreamble_UserTab();
        UT.getuserName();
        UT.getCount();
        UT.getLicense();
        UT.getUsed();
        UT.getRemaining();
        UT.getTotal();
        
        Test.stopTest();
        
    }

}