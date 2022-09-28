public class uploadBusinessDocuments {
    @AuraEnabled  
    public static List<ContentDocument> getFiles(string recordId){  
        List<ContentDocument> DocumentList = new List<ContentDocument>();  
        Set<Id> documentIds = new Set<Id>();  //store file ids
        List<ContentDocumentLink> cdl=[select id,LinkedEntityId,ContentDocumentId from ContentDocumentLink where LinkedEntityId=:recordId];  
        for(ContentDocumentLink cdLink:cdl){  
            documentIds.add(cdLink.ContentDocumentId);  // Document ids
        }      
        DocumentList = [select Id,Title,FileType,ContentSize,Description from ContentDocument where id IN: documentIds];  
        return DocumentList;  
    }  
    @AuraEnabled  
    public static List<ContentDocument> UpdateFiles(string documentId,string title,string recordId){//, string documentType){  
        system.debug('title: ' +title); 
        
        ContentVersion a = [SELECT Id, VersionData,ContentDocumentId FROM ContentVersion WHERE ContentDocumentId = :documentId];//Document_Type__c
        //a.Document_Type__c=documentType;
        try{  
            update a;
        }  
        catch(DMLException e){  
            system.debug('Exception has occurred! ' +e.getMessage());  
        }  
        ContentDocument cd = [select id,title from ContentDocument where Id=:documentId]; // Getting files from Parent record 
        cd.Title = title;  // Changing file Title with user entered title       
        try{  
            update cd;  // Update ContentDocument (File)
        }  
        catch(DMLException e){  
            system.debug('Exception has occurred! ' +e.getMessage());  
        }  
        List<ContentDocument> DocumentList = new List<ContentDocument>();  
        Set<Id> documentIds = new Set<Id>();  
        List<ContentDocumentLink> cdl=[select id,LinkedEntityId,ContentDocumentId from ContentDocumentLink where LinkedEntityId=:recordId];  
        for(ContentDocumentLink cdLink:cdl){  
            documentIds.add(cdLink.ContentDocumentId);  
        }      
        DocumentList = [select Id,Title,FileType,ContentSize,Description from ContentDocument where id IN: documentIds];  
        return DocumentList;  // Return list of files on parent record
    }  
    
   /* @AuraEnabled
    public static Response deleteAttachment(String attachmentIdToDelete, String linkedEntityId) {
        Response resp;
        try {
            if(String.isNotBlank(attachmentIdToDelete) && String.isNotBlank(linkedEntityId)) {
                List<ContentDocumentLink> documentLinkToDelete = [SELECT Id FROM ContentDocumentLink WHERE LinkedEntityId = :linkedEntityId AND ContentDocumentId = :attachmentIdToDelete];
                if(!documentLinkToDelete.isEmpty()) {
                    DELETE documentLinkToDelete;
                }
                resp = new Response(true, null, null);
            }
        } catch(Exception e) {
            resp = new Response(false, e.getMessage(), null);
        }
        return resp;
    }*/
    
}