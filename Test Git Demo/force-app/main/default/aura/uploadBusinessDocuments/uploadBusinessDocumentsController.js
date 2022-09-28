({  
    doInit:function(component,event,helper){  
        var action = component.get("c.getFiles");  
        action.setParams({  
            "recordId":component.get("v.recordId")  
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
                
                
                console.log('result: ' +result);  
                component.set("v.files",result);  
            }  
        });  
        $A.enqueueAction(action);  
    } ,  
    //Open File onclick event  
    OpenFile :function(component,event,helper){  
        var rec_id = event.currentTarget.id;  
        $A.get('e.lightning:openFiles').fire({ //Lightning Openfiles event  
            recordIds: [rec_id] //file id  
        });  
    },  
    UploadFinished : function(component, event, helper) {  
        var uploadedFiles = event.getParam("files");  
        var documentId = uploadedFiles[0].documentId;  
        var fileName = uploadedFiles[0].name;  
        helper.UpdateDocument(component,event,documentId);  
        var toastEvent = $A.get("e.force:showToast");  
        toastEvent.setParams({  
            "title": "Success!",  
            "message": "File "+fileName+" Uploaded successfully." ,
            "type": "success"
        });  
        toastEvent.fire();  
        /* Open File after upload  
     $A.get('e.lightning:openFiles').fire({  
       recordIds: [documentId]  
     });*/  
   },  
    /*checkValidityJs :function(component,event,helper){
        var auraIds = ["tax940","tax942"]        
        let isAllValid = auraIds.reduce(function(isValidSoFar, auraIds){
            //display the error messages
            var inputCmp = component.find(auraIds);
            if(inputCmp) {
                inputCmp.reportValidity();
                //form will be invalid if any of the field's valid property provides false value.
                return isValidSoFar && inputCmp.checkValidity();
            } else {
                return isValidSoFar && true;
            }
        },true);
        if(isAllValid) {
            component.set("v.isValidated",true);
            //helper.saveBusinessInformation(component, event, helper, 3);
        }else{
            component.set("v.isValidated",false);
        }
    },*/
    checkValidityJs :function(component,event,helper){
        var businessType = component.get("v.businessType");
        var dba = component.get("v.DBAName");
        var form940 = component.get("v.form940");
        var form941 = component.get("v.form941");
        var regDoc = component.get("v.regDoc");
        var articleOfInc = component.get("v.articleOfIncorporation");
        //var form940Value = form940.get('v.value');
        if(businessType == 'Sole Proprietor' || businessType == 'Independent Contractor' || businessType == 'Eligible Self-Employed individual') {
            if(form940 == true && form941 == true)
                component.set("v.isValidated",true);
            //helper.saveBusinessInformation(component, event, helper, 3);
            else{
                component.set("v.isValidated",false);
                helper.toast(false,'Please upload all the required documents');
            }      
        }
        if((businessType == 'Sole Proprietor' || businessType == 'Independent Contractor' || businessType == 'Eligible Self-Employed individual') && dba) {
            if(form940 == true && form941 == true && regDoc == true)
                component.set("v.isValidated",true);
            //helper.saveBusinessInformation(component, event, helper, 3);
            else{
                component.set("v.isValidated",false);
                helper.toast(false,'Please upload all the required documents');
            }      
        }
        /*if(businessType == 'Independent Contractor') {
            if(form940 == true && form941 == true)
                component.set("v.isValidated",true);
            //helper.saveBusinessInformation(component, event, helper, 3);
            else{
                component.set("v.isValidated",false);
                helper.toast(false,'Please upload all the required documents');
            }      
        }
        if(businessType == 'Eligible Self-Employed individual') {
            if(form940 == true && form941 == true)
                component.set("v.isValidated",true);
            //helper.saveBusinessInformation(component, event, helper, 3);
            else{
                component.set("v.isValidated",false);
                helper.toast(false,'Please upload all the required documents');
            }      
        }*/
        if(businessType == 'Cooperative' || businessType == 'S-Corp' || businessType == 'LLC') {
            if(form940 == true && form941 == true && regDoc == true)
                component.set("v.isValidated",true);
            //helper.saveBusinessInformation(component, event, helper, 3);
            else{
                component.set("v.isValidated",false);
                helper.toast(false,'Please upload all the required documents');
            }      
        }
        if((businessType == 'Cooperative' || businessType == 'S-Corp' || businessType == 'LLC') && dba) {
            if(form940 == true && form941 == true && regDoc == true && articleOfInc == true )
                component.set("v.isValidated",true);
            //helper.saveBusinessInformation(component, event, helper, 3);
            else{
                component.set("v.isValidated",false);
                helper.toast(false,'Please upload all the required documents');
            }      
        }
        /*if(businessType == 'S-Corp') {
            if(form940 == true && form941 == true)
                component.set("v.isValidated",true);
            //helper.saveBusinessInformation(component, event, helper, 3);
            else{
                component.set("v.isValidated",false);
                helper.toast(false,'Please upload all the required documents');
            }      
        }
        if(businessType == 'LLC') {
            if(form940 == true && form941 == true)
                component.set("v.isValidated",true);
            //helper.saveBusinessInformation(component, event, helper, 3);
            else{
                component.set("v.isValidated",false);
                helper.toast(false,'Please upload all the required documents');
            }      
        }*/
        
    },
    removeAttachment: function(component, event, helper) {
        var indexToDelete = event.currentTarget.dataset.value;
        var FileList = component.get("v.files");
        if(FileList && FileList[indexToDelete]) {
            //var id = FileList[indexToDelete].Id;
            var id = FileList[indexToDelete].Id;
            if(id) {
                helper.removeAttachment(component, event, helper, id, indexToDelete);
            } else {
                FileList.splice(indexToDelete, 1);
                component.set("v.files", FileList);
            }
        }
    }
    
})