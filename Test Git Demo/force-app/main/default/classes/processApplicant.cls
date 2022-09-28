global class processApplicant implements 
        Messaging.InboundEmailHandler {
Candidate__c[] newCandidate = new Candidate__c[0];
Job_Application__c[] newJobApplication = 
        new Job_Application__C[0];
 global Messaging.InboundEmailResult handleInboundEmail(
  Messaging.InboundEmail email, 
  Messaging.InboundEnvelope envelope) {
Messaging.InboundEmailResult result = 
        new Messaging.InboundEmailresult();
 String emailAddress = envelope.fromAddress;
 String fName = email.fromname.substring(
        0,email.fromname.indexOf(' '));
String lName = email.fromname.substring(
        email.fromname.indexOf(' '));
    try
    {
      newCandidate.add(new Candidate__c(
      first_name__c = fName,
      last_name__c = lName
     )
   );
 
      insert newCandidate;
   }
    catch (System.DmlException e)
   {
System.debug('ERROR: Not able to create candidate: ' + e);
   }
 
Position__c pos;
pos = [select ID from Position__c where name =
             :email.subject limit 1];
    ID jobId = pos.ID;
 
 // Associates the candidate with the job application  
    
newJobApplication.add(new Job_Application__c(
        Position__c = jobId,candidates__c = newCandidate[0].id));
 
   insert newJobApplication;

return result;
    }   
}