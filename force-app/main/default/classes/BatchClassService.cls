global with sharing class BatchClassService implements Database.Batchable<SObject> {
    
    public Id AccountId {get;set;}
    public string AccountAddress {get;set;}
    public List<Contact> contacts;
   
    global BatchClassService(List<Contact> conList, string acAddress)
    {
        this.AccountAddress = acAddress;
        this.contacts = conList;
    }

    global Iterable<SObject> start(Database.BatchableContext BC)
    {
        System.debug('start Scope');
        return contacts;
    }
    global void execute(Database.BatchableContext BC, List<Contact> scope)
    {
        System.debug('start execute');
        System.debug('Contacts List: ' + scope);
        for (Contact item : scope) {
            item.Address__c = AccountAddress;
        }
        update scope;
        System.debug('end Scope');
    }
    global void finish(Database.BatchableContext BC)
    {

    }
}
