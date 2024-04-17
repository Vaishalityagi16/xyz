trigger AccountTrigger on Account(Before insert,Before Update,After insert, After Update) {
    if(trigger.isBefore){
        if(trigger.isinsert){
            AccountTriggerController.AccountTriggerMethod(trigger.new);
        }
        else if(trigger.isUpdate){
            AccountTriggerController.AccountTriggerMethod(trigger.new);
        }
    }
    else if(trigger.isAfter){
        if(trigger.isinsert){
            AccountTriggerController.AccountTriggerMethod(trigger.new);
        }
        else if(trigger.isUpdate){
            AccountTriggerController.AccountTriggerMethod(trigger.new);
        }
    }
    
}