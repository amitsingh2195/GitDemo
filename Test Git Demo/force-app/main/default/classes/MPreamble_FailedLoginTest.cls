@isTest
public class MPreamble_FailedLoginTest {
    
    public static testMethod void TestProfileType(){
        
        List<LoginHistory> lh = new List<LoginHistory>();
        lh = [Select Id, Status, UserId, Browser, APIVersion,
                                     LoginTime from LoginHistory LIMIT 1];
        
        
        Fcias__MPreambleLog__c MP = new Fcias__MPreambleLog__c();
        MP.Fcias__User_Name__c = 'TestAccount';
        MP.Fcias__Failed_Login_Count__c = 5;
        MP.Fcias__User_Id__c = lh[0].userId;        
        insert MP;
        
        /*List<Fcias__MPreambleLog__c> Mlog = [Select Id, Fcias__User_Name__c,Fcias__Failed_Login_Count__c,Fcias__User_Id__c 
                                             from Fcias__MPreambleLog__c where Fcias__Failed_Login_Count__c !=0];
        
        delete MLog;
        */
                
        Test.startTest();
       // MPreamble_FailedUserLogin cntlr = new MPreamble_FailedUserLogin();
        MPreamble_FailedUserLogin.MPreamble_FailedLoginAttempts();
        //cntlr.getName();
        // cntlr.getNew();
        Test.stopTest();

    }

}