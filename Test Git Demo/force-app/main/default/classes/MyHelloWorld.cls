public class MyHelloWorld {
    
    public static void applyDiscount(Fcias__Book__c[] books){
        for(Fcias__Book__c b: books){
            b.Fcias__Price__c *= 0.9;
        }           
    }
}