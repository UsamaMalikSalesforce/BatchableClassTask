public with sharing class QueableClassService implements Queueable {
    public List<AddressUpdateModel> data;
    
    public QueableClassService(List<AddressUpdateModel> data)
    {
        this.data = data;
    }

    public void execute(QueueableContext QC)
    {
        if(data.size() > 0)
        {
            List<Contact> conList = [Select Id,Name,Address__c from Contact where AccountId =: data[0].account.Id];
            this.UpdateContacts(conList, data[0].address);
            data.remove(0);
            if(data.size() > 0)
            {
            QueableClassService recursiveObj = new QueableClassService(data);
            System.enqueueJob(recursiveObj);
            }
        }
        
        
    }
    public void UpdateContacts(List<Contact> contacts, string address)
    {
        for (Contact item : contacts) {
            item.Address__c = address;
        }
        update contacts;
    }

}
