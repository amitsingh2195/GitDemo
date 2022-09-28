public class MPreamble_UserLicenses{
    
    
    public static void UserLicense(){
        List<Fcias__MPreambleLog__c> insertToLog = new List<Fcias__MPreambleLog__c>(); //Empty list to insert new records in MPreamble object
        List<UserLicense> licenses = [SELECT LicenseDefinitionKey, Name, UsedLicenses, TotalLicenses from UserLicense]; //List of records from UserLicenses API
              
        List<Fcias__MPreambleLog__c> LicensetoDelete = [Select Fcias__Salesforce_Licenses_Id__c from Fcias__MPreambleLog__c where Fcias__Salesforce_Licenses_Id__c !=null]; //List of old records in MPreamble object
        if(!LicensetoDelete.isEmpty())
        {
            delete LicensetoDelete;	
        }
        	 
            for(UserLicense license : licenses) 
        	{
            Fcias__MPreambleLog__c MPreamble = new Fcias__MPreambleLog__c(); //Create instance of MPreamble object
            MPreamble.Fcias__Salesforce_Licenses_Id__c = license.LicenseDefinitionKey;
            MPreamble.Fcias__Salesforce_License_Name__c = license.Name;
            MPreamble.Fcias__Salesforce_Used_Licenses__c = license.UsedLicenses;
            MPreamble.Fcias__Salesforce_Total_Licenses__c = license.TotalLicenses;
            insertToLog.add(MPreamble); //Add values to InsertToLog List
        	}
   
        insert insertToLog;
    }
    

        /*// Method used for Chart.JS--->
    	public String getName() 
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
        
         	} */ 
   
}