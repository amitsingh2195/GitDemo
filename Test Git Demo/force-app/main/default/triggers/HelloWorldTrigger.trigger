trigger HelloWorldTrigger on Fcias__Book__c (before insert) {
    Fcias__Book__c[] books = Trigger.new;
    system.debug('Values in trigger.new-->'+ books);
    MyHelloWorld.applyDiscount(books);
    
    Map<ID,Fcias__Book__c> BookMap = new Map<ID,Fcias__Book__c>([select ID, Name from Fcias__Book__c]);
    System.debug('Values in Map-->' + BookMap);

}