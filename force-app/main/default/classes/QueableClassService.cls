public with sharing class QueableClassService implements Queueable {
    public Id AccountId {get;set;}
    public string AccountAddress {get;set;}
    public QueableClassService(Id AccountId, String AccountAddress) {
        this.AccountId = AccountId;
        this.AccountAddress = AccountAddress;
    }

    public void execute(QueueableContext QC)
    {
        List<Contact> contacts = [Select Id,Name,Address__c from Contact where AccountId =: AccountId];
        if(contacts.size() > 0)
        {
            for (Contact item : contacts) {
                item.Address__c = AccountAddress;
            }
            update contacts;
        }
    }

}
