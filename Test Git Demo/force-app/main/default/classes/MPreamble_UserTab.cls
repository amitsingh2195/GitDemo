public class MPreamble_UserTab {
    
    //Failed User Login charts
        // Method used for Chart.JS--->
    public String getuserName() 
    	{  
         String[] ChartItems = new String[]{};
         String str;
         List<Fcias__MPreambleLog__c> dataItems = [SELECT Fcias__User_Name__c FROM Fcias__MPreambleLog__c where Fcias__Failed_Login_Count__c != Null];
         system.debug(dataItems);
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
        
         }  
		
    
    
    
    //User Licenses
    	        // Method used for Chart.JS--->
    	public String getLicense() 
    		{  
         	String[] ChartItems = new String[]{};
         	String str;
         	List<Fcias__MPreambleLog__c> dataItems = [SELECT Fcias__Salesforce_License_Name__c FROM Fcias__MPreambleLog__c 
                                                      where Fcias__Salesforce_Used_Licenses__c != NULL and Fcias__Salesforce_Used_Licenses__c !=0]; 
                                                      
         	for (Fcias__MPreambleLog__c dataSO : dataItems) 
        		{
            		str= String.valueOf(dataSO.Fcias__Salesforce_License_Name__c);
              		ChartItems.add(str);
            	}

    			return JSON.serialize(ChartItems);
    		}
    
    	//Method used for Chart.JS--->  
    	public String getUsed() 
    		{
         	List<Fcias__MPreambleLog__c> UserItems = [SELECT Fcias__Salesforce_Used_Licenses__c FROM Fcias__MPreambleLog__c 
                                                      where Fcias__Salesforce_Used_Licenses__c != NULL and Fcias__Salesforce_Used_Licenses__c !=0];
         	Integer[] UsedLicense=new Integer[]{};
         	Integer used;
         		for(Fcias__MPreambleLog__c td: UserItems)
            		{
                		used=Integer.valueOf(td.Fcias__Salesforce_Used_Licenses__c);
                    	UsedLicense.add(used);
					}
					return JSON.serialize(UsedLicense); 
        
         	}   
    
    	public String getRemaining() 
    		{
         	List<Fcias__MPreambleLog__c> UserItems = [SELECT Fcias__Salesforce_Remaining_Licenses__c FROM Fcias__MPreambleLog__c 
                                                      where Fcias__Salesforce_Used_Licenses__c != NULL and Fcias__Salesforce_Used_Licenses__c !=0];
         	Integer[] RemainingLicense=new Integer[]{};
         	Integer remaining;
         		for(Fcias__MPreambleLog__c td: UserItems)
            		{
                		remaining=Integer.valueOf(td.Fcias__Salesforce_Remaining_Licenses__c);
                    	RemainingLicense.add(remaining);
					}
					return JSON.serialize(RemainingLicense); 
        
         	}     
    
        public String getTotal() 
    		{
         	List<Fcias__MPreambleLog__c> UserItems = [SELECT Fcias__Salesforce_Total_Licenses__c FROM Fcias__MPreambleLog__c 
                                                      where Fcias__Salesforce_Used_Licenses__c != NULL	 and Fcias__Salesforce_Used_Licenses__c !=0];
         	Integer[] TotalLicense=new Integer[]{};
         	Integer total;
         		for(Fcias__MPreambleLog__c td: UserItems)
            		{
                		total=Integer.valueOf(td.Fcias__Salesforce_Total_Licenses__c);
                    	TotalLicense.add(total);
					}
					return JSON.serialize(TotalLicense); 
        
         	}  

}