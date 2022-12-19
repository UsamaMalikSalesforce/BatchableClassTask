public with sharing class QueableClassService implements Queueable {
    public List<AddressUpdateModel> data;
    
    public QueableClassService(List<AddressUpdateModel> data)
    {
        this.data = data;
    }

    public void execute(QueueableContext QC)
    {
        this.CreateLogs();
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
        this.CreateLogs();
        
    }
    public void UpdateContacts(List<Contact> contacts, string address)
    {
        // for (Contact item : contacts) {
        //     item.Address__c = address;
        // }
        // update contacts;
        BatchClassService obj = new BatchClassService(contacts,address);
        Id batchJobId = Database.executeBatch(obj,100);
    }
    public void CreateLogs()
    {
        System.debug('Custom Log => DML SOQL: ' + Limits.getQueryRows() + '/' + Limits.getLimitQueryRows()  );
        System.debug('Custom Log => DML Statements: ' + Limits.getDmlStatements() + '/' + Limits.getLimitDmlStatements()  );
        System.debug('Custom Log => DML CPU Time: ' + Limits.getCpuTime() + '/' + Limits.getLimitCpuTime()  );
        System.debug('Custom Log => DML ROWS: ' + Limits.getDmlRows() + '/' + Limits.getLimitDmlRows()  );
        System.debug('Custom Log => DML Heap Size: ' + Limits.getHeapSize() + '/' + Limits.getLimitHeapSize()  );
    }

}
