({  
    UpdateDocument : function(component,event,Id) {  
        var action = component.get("c.UpdateFiles");  
        var fName = component.find("fileName").get("v.value");  
        //alert('File Name'+fName);  
        action.setParams({"documentId":Id,  
                          "title": fName,  
                          "recordId": component.get("v.recordId"),
                          "documentType": fName
                         });  
        action.setCallback(this,function(response){  
            var state = response.getState();  
            if(state=='SUCCESS'){  
                var result = response.getReturnValue();  
                
                result.forEach(checkForms);
                function checkForms(item){
                    if(item.Title == 'TAX_940'){
                        component.set("v.form940",true);
                    }
                    if(item.Title == 'TAX_941'){
                        component.set("v.form941",true);
                    }
                    if(item.Title == 'CERTIFICATE OF FORMATION'){
                        component.set("v.regDoc",true);
                    }
                    if(item.Title == 'ARTICLES OF INCORPORATION'){
                        component.set("v.articleOfIncorporation",true);
                    }
                }
                
                console.log('Result Returned: ' +result);  
                component.find("fileName").set("v.value", " ");  
                component.set("v.files",result);  
            }  
        });  
        $A.enqueueAction(action);  
    },  
    removeAttachment: function(component, event, helper, attachmentIdToDelete, index) {
        var linkedEntityId = component.get("v.recordId");
        var action = component.get("c.deleteAttachment");
        action.setParams({attachmentIdToDelete: attachmentIdToDelete, linkedEntityId: linkedEntityId});
        // Create a callback that is executed after 
        // the server-side action returns
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {                
                var applicationData = response.getReturnValue();
                if(applicationData.success) {
                    var FileList = component.get("v.files");
                    FileList.splice(index, 1);
                    component.set("v.files", FileList);
                    $A.get('e.force:refreshView').fire();
                } else {
                    console.log("Error message: " + applicationData.message);
                }
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                    errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        // $A.enqueueAction adds the server-side action to the queue.
        $A.enqueueAction(action);
    },
    toast : function(aok, msg) {
        var toastEvent = $A.get('e.force:showToast');
        toastEvent.setParams({
            type: aok ? 'success' : 'error',
            title: aok ? 'Success!' : 'Error!',
            message: msg
        });
        toastEvent.fire();
    },
})