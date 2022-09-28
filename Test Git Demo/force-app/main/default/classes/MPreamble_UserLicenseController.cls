public class MPreamble_UserLicenseController {

    public ApexPages.StandardSetController li{
    get{
        if(li==null){
            li = new ApexPages.StandardSetController(Database.getQueryLocator([Select Fcias__Salesforce_License_Name__c, 
            Fcias__Salesforce_Used_Licenses__c, Fcias__Salesforce_Total_Licenses__c, Fcias__Salesforce_Remaining_Licenses__c 
            from Fcias__MPreambleLog__c where (Fcias__Salesforce_Licenses_Id__c != null) AND Fcias__Salesforce_Used_Licenses__c !=0]));
        }
        return li;   
    }
    set;
    
    }
    public List<Fcias__MPreambleLog__c> getLicenses() {
        return (List<Fcias__MPreambleLog__c>)li.getRecords();
    }

}