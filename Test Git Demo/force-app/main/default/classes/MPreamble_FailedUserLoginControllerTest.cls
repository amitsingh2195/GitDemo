@isTest
public class MPreamble_FailedUserLoginControllerTest {
    
    public static testMethod void TestController(){
		
        List<Fcias__MPreambleLog__c> MPList = new List<Fcias__MPreambleLog__c>();
        
        Fcias__MPreambleLog__c MP = new Fcias__MPreambleLog__c();
        MP.Fcias__User_Id__c = 'ABCD';
        MP.Fcias__User_Name__c = 'TestName';
        MP.Fcias__Failed_Login_Count__c = 10;
        MPList.add(MP);
        
        Fcias__MPreambleLog__c MP1 = new Fcias__MPreambleLog__c();
        MP1.Fcias__User_Id__c = 'ABCD1';
        MP1.Fcias__User_Name__c = 'TestName1';
        MP1.Fcias__Failed_Login_Count__c = 11;
        MPList.add(MP1);
        
   		insert MPList;
       
 		Test.startTest();
		MPreamble_FailedUserLoginController testCount = new MPreamble_FailedUserLoginController();
        testcount.getFailedCount();
 		Test.stopTest();
        
    }
}