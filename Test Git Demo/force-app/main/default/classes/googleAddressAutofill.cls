public with sharing class googleAddressAutofill {
    
    @AuraEnabled
    public static string getSuggestions(String input) {
       String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?'
            + 'input=' + EncodingUtil.urlEncode(input, 'UTF-8')
            + getKey();   
      
        String response = getResponse(url); 
        system.debug('Response suggestions***'+response);
        return response;
    }
    
    
    @AuraEnabled
    public static string getPlaceDetails(String placeId) {
        String url = 'https://maps.googleapis.com/maps/api/place/details/json?'
            + 'placeid=' + EncodingUtil.urlEncode(placeId, 'UTF-8')
            + getKey(); 
        String response = getResponse(url);
        system.debug('Response places****'+response);
        return response;
    }
    
     
    public static string getResponse(string strURL){
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        req.setMethod('GET');
        req.setEndpoint(strURL);
        req.setTimeout(120000);
        res = h.send(req); 
        system.debug('Raw Resp---'+res);
        String responseBody = res.getBody(); 
        system.debug('responseBody---'+responseBody);
        return responseBody; 
    }
    
    
    public static string getKey(){
        /*Enter your API key here*/
        string key = 'AIzaSyDzKiaHPxOtuFmMdmCL0RvgwxV8I614lEI';
        string output = '&key=' + key;   
        return output;
    }
    
    @AuraEnabled
    public static string getAddress(String dealId ,String street, String city , String state, String country,string zip){
    	
    	Opportunity opp = new Opportunity();
    	warpper wrap = new warpper();
    	if(dealId != null){
    		try{
    			//opp = [select id,Property_State__c,Property_Country__c,Property_City__c,Property_Street__c,Property_Zip_Postal_Code__c from Opportunity where id=: dealId];
    			//opp.Property_State__c = state;
    			//opp.Property_Country__c = country;
    			//opp.Property_City__c = city;
                //opp.Property_Zip_Postal_Code__c = zip;
                //opp.Property_Street__c = street;
    			update opp;
    			system.debug('*****Successfully updated the Deal');
    			
                wrap.isSuccess = true;
    		}catch(Exception e){
                wrap.isSuccess = false;
                wrap.errormessage = e.getMessage().substringAfter(',');
    			system.debug('Exception**'+e.getLinenumber());
    		}
    	}
    	return JSON.serialize(wrap);
    } 
    
    @AuraEnabled
    public static string setAddress(String accountId,String street2, String dealId ,String street, String city , String state, String country,string zip){
    	
    	Account acc = new Account();
    	warpper wrap = new warpper();
    	//if(dealId != null){
    		try{
    			//acc = [SELECT Id,Name,Formation_Date__c,DBA_or_Trade_Name__c,Phone,BillingStreet,Address_2__c,BillingCity,BillingState,BillingPostalCode,Primary_Contact__c,NaicsDesc,Loan_Purpose__c,AccountNumber, Business_Legal_Type__c, Type_of_Business__c,Tin__c, Primary_Address__c, PrimarySameAsBusinessAdd__c, Business_address__c, Applicant_Business__c, Principal_Name__c, Social_Security_Number__c, Citizenship__c, Registration_Number__c, Country_of_Citizenship__c,Active__c,AnnualRevenue FROM ACCOUNT WHERE Id = :accountId];
    			acc.BillingStreet = street;
                //acc.Address_2__c = street2;
                acc.BillingState = state;
                acc.BillingCountry = country;
    			acc.BillingCity = city;
                acc.BillingPostalCode = zip;
                acc.BillingStreet = street;
    			update acc;
    			system.debug('*****Successfully updated the Deal');
    			
                wrap.isSuccess = true;
    		}catch(Exception e){
                wrap.isSuccess = false;
                wrap.errormessage = e.getMessage().substringAfter(',');
    			system.debug('Exception**'+e.getLinenumber());
    		}
    	//}
    	return JSON.serialize(wrap);
    } 
    
    @AuraEnabled
    public static boolean getOppStage(String oppId){
    	List<Opportunity> opplist = new List<Opportunity>();
    	Boolean notstage ; 
    	if(oppId != null){
    		opplist = [select id , StageName from Opportunity where id=: oppId];
    		if(opplist[0].StageName == '06 - Mortgage Booked'){
    			notstage = true;
    		}else{
    			notstage = false;
    		}
    	}
    	return notstage;
    }
    
    public class warpper{
        @AuraEnabled
        public boolean isSuccess{get;set;}
        
        @AuraEnabled
        public String errormessage{get;set;}
    }
}