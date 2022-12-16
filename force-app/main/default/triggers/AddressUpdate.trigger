trigger AddressUpdate on Account (before insert,after insert, before update, after update) {
    switch on Trigger.operationType {
        when AFTER_UPDATE {
            AddressUpdateTriggerHandler.afterUpdateHandler(Trigger.new,Trigger.oldMap);
        }
        when else {
            
        }
    }
}