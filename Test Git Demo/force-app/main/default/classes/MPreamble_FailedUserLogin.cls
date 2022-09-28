public class MPreamble_FailedUserLogin {
    
    
    public static void MPreamble_FailedLoginAttempts(){
        Map<Id,User> users =new Map<Id,User>([Select Id, Name from User]); //Map of Users from User API
        Map<Id,List<LoginHistory >> loginDetials = new Map<Id,List<LoginHistory >>(); //Map of Id and Login History
        List<Fcias__MPreambleLog__c> insertTestUser = new List<Fcias__MPreambleLog__c>(); //List to insert 
        List<Fcias__MPreambleLog__c> updateTestUser = new List<Fcias__MPreambleLog__c>();
        
        List<LoginHistory> LHList = [SELECT Id, Status, UserId, Browser, APIVersion,
                                     LoginTime from LoginHistory where UserId=:users.keySet() Limit 50000 ]; //Adding login history 
        
        
        for(LoginHistory lh:LHList)
        {
            if(lh.Status != 'Success'){
                System.debug('IF-->Failure');
                if(!loginDetials.ContainsKey(lh.UserId))
                {
                    loginDetials.put(lh.UserId, new List<LoginHistory>{lh});
                }
                else
                {
                    loginDetials.get(lh.UserId).add(lh);
                }               
            }
            else{
                System.debug('ELSE-->Success');
            }
            
        }
        
         List<Fcias__MPreambleLog__c> userDataList = new List<Fcias__MPreambleLog__c>([SELECT Fcias__User_Id__c,Fcias__Failed_Login_Count__c FROM Fcias__MPreambleLog__c]);
        //Set<Id> failedUserIds = new Set<Id>();
        Map<String, Fcias__MPreambleLog__c> failedUserMap = new Map<String, Fcias__MPreambleLog__c>();
        for(Fcias__MPreambleLog__c u: userDataList){
            failedUserMap.put(u.Fcias__User_Id__c,u);
        }
        System.debug('failedUserMap-->'+failedUserMap);    
        
        for(Id uId : loginDetials.keySet()){
            
            Fcias__MPreambleLog__c obj = new Fcias__MPreambleLog__c();
            List<LoginHistory> lHistory = loginDetials.get(uId);
            Integer noOfFailure = lHistory.size();
            
            if(failedUserMap.containsKey(uId)){
                System.debug('if - existing');
                failedUserMap.get(uId).Fcias__Failed_Login_Count__c=noOfFailure;
                failedUserMap.get(uId).Fcias__User_Name__c=users.get(uId).Name;
                updateTestUser.add(failedUserMap.get(uId));
            }
            else{
                System.debug('else - non-existing');
                obj.Fcias__User_Id__c= uId;
                obj.Fcias__Failed_Login_Count__c= noOfFailure;
                obj.Fcias__User_Name__c= users.get(uId).Name;
                insertTestUser.add(obj);
            }
            
        }
        
        if(!insertTestUser.isEmpty()){
            System.debug('insertTestUser-->'+insertTestUser);
            insert insertTestUser;
        }
        
        if(!updateTestUser.isEmpty()){
            System.debug('updateTestUser-->'+updateTestUser);
            update updateTestUser;
        }        
    }
            
    /*// Method used for Chart.JS--->
    public String getuserName() 
    	{  
         String[] ChartItems = new String[]{};
         String str;
         List<Fcias__MPreambleLog__c> dataItems = [SELECT Fcias__User_Name__c FROM Fcias__MPreambleLog__c where Fcias__Failed_Login_Count__c != Null];
         for (Fcias__MPreambleLog__c dataSO : dataItems) 
        	{
            	str= String.valueOf(dataSO.Fcias__User_Name__c);
              	ChartItems.add(str);
            }

    		return JSON.serialize(ChartItems);
    	}
    
    //Method used for Chart.JS--->
    public String getCount() 
    	{
         List<Fcias__MPreambleLog__c> UserItems = [SELECT Fcias__Failed_Login_Count__c FROM Fcias__MPreambleLog__c where Fcias__Failed_Login_Count__c != Null];
         Integer[] FailedCount=new Integer[]{};
         Integer count;
         	for(Fcias__MPreambleLog__c td: UserItems)
            	{
                	count=Integer.valueOf(td.Fcias__Failed_Login_Count__c);
                    FailedCount.add(count);
				}
				return JSON.serialize(FailedCount); 
        
         } */ 
}