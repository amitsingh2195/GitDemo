@RestResource(urlMapping='/v1/testIntegration/')
global class TestIntegration {
    @HttpGet
    global static Contact doGetContact(){
        Contact Cont = new Contact();
        Map<String,String> paramMap = RestContext.request.params;
        string ContId = paramMap.get('Id');
        Cont = [select id, Name, LastName, FirstName, Salutation from contact where id =: ContId];
        return Cont;
    }

    
    @HttpDelete
    global static String doDeleteContact(){
        Contact Cont = new Contact();
        Map<String,String> paramMap = RestContext.request.params;
        string ContId = paramMap.get('Id');
        Cont = [select id, Name, LastName, FirstName, Salutation from contact where id =: ContId];
        delete Cont;
        return 'Contact is Successfully deleted';
    }
    
    
    @HttpPost
    global static Contact doCreateContact(ContsInfo contInfo){
		Contact con = contInfo.cont;
        insert con;
        return con;
    }
    
    @HttpPut
    global static Contact doUpdateContact(String salute, String firstName, String lastName){
        Map<String, String> paramMap = RestContext.request.params;
        String contId = paramMap.get('Id');
        Contact con = new Contact (Id= contId, Salutation = salute, FirstName = firstName, LastName = lastName);
        update con;
        return con;
    }  
    
    global class ContsInfo{
        Contact cont { get; set;}
    }
}