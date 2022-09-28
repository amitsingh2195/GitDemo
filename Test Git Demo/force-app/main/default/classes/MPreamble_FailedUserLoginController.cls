public class MPreamble_FailedUserLoginController {
    
		public static ApexPages.StandardSetController li{
    		get{
        		if(li==null){
            		li = new ApexPages.StandardSetController(Database.getQueryLocator([Select Fcias__User_Name__c, 
            		Fcias__Failed_Login_Count__c from Fcias__MPreambleLog__c where Fcias__Failed_Login_Count__c !=null]));
        			}
        		return li;   
    			}
    			set;
    			}
    	public List<Fcias__MPreambleLog__c> getFailedCount() {
        	return (List<Fcias__MPreambleLog__c>)li.getRecords();
    	}
}