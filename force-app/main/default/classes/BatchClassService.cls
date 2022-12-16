global with sharing class BatchClassService implements Database.Batchable<SObject> {
    
    public Id AccountId {get;set;}
    public string AccountAddress {get;set;}
    global BatchClassService(Id AccountId, String AccountAddress)
    {
        this.AccountId = AccountId;
        this.AccountAddress = AccountAddress;
    }

    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        System.debug('Account Id: ' + AccountId);
        System.debug('start Scope');
       // string query = 'Select Id,Name,Address__c from Contact where AccountId=' + AccountId;
        System.debug('end Scope');
        return Database.getQueryLocator([Select Id,Name,Address__c from Contact where AccountId =: AccountId]);
       
        
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
