public with sharing class AddressUpdateTriggerHandler {
    
    public static void afterUpdateHandler(List<Account> newAccounts,Map<Id,Account>oldAccount)
    {
        if(newAccounts.size() > 0)
        {
            System.debug('Custom Log Accounts Size: ' + newAccounts.size() );
            List<AddressUpdateModel> data = new List<AddressUpdateModel>(); 
            for (Account item : newAccounts) {
                if(oldAccount.get(item.Id).Address__c != item.Address__c)
                {
                    
                    AddressUpdateModel obj = new AddressUpdateModel();
                    obj.account = item;
                    obj.address = item.Address__c;
                    data.add(obj);
                    
                    //BatchClassService obj = new BatchClassService(item.Id,item.Address__c);
                    //Id batchJobId = Database.executeBatch(obj,100);
                }
            } 

              if(data.size() > 0 )
            {
            QueableClassService qcs = new QueableClassService(data);
            Id jobId = System.enqueueJob(qcs);
            System.debug('Custom Log Job Id: ' + jobId);
            } 
          
        }
    }
}
