@isTest
public class HelloWorldTestClass {
    static testMethod void validateHelloWorld() {
        Fcias__Book__c b = new Fcias__Book__c(Name='Behind the Cloud', Fcias__Price__c=100);
        System.debug('Price before inserting new book: ' + b.Fcias__Price__c);
        
        // Insert book
        insert b;
        
        // Retrieve the new book
        b = [SELECT Fcias__Price__c FROM Book__c WHERE Id =:b.Id];
        System.debug('Price after trigger fired: ' + b.Fcias__Price__c);
        
        // Test that the trigger correctly updated the price
        System.assertEquals(90, b.Price__c);   
    }
}