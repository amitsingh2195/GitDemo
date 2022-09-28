trigger BatchApexErrorTrigger on BatchApexErrorEvent (After insert) {
	
    BatchLeadConvertErrors__c[] insertErrorList = new BatchLeadConvertErrors__c[]{};
        
        for (BatchApexErrorEvent err : Trigger.new){
            BatchLeadConvertErrors__c tmpLog = new BatchLeadConvertErrors__c();
            tmpLog.AsyncApexJobId__c = err.AsyncApexJobId;
            tmpLog.Records__c = err.JobScope;
            tmpLog.StackTrace__c = err.StackTrace;
            insertErrorList.add(tmpLog);
        }
    insert insertErrorList;
}