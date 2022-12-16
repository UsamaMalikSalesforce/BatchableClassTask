public with sharing class AddressUpdateTriggerHandler {
    
    public static void afterUpdateHandler(List<Account> newAccounts,Map<Id,Account>oldAccount)
    {
        if(newAccounts.size() > 0)
        { 
            for (Account item : newAccounts) {
                if(oldAccount.get(item.Id).Address__c != item.Address__c)
                {
                    BatchClassService obj = new BatchClassService(item.Id,item.Address__c);
                    Id batchJobId = Database.executeBatch(obj,100);
                    System.debug('Custom Log Job Id: ' + batchJobId);
                }
            }
        }
    }
}
