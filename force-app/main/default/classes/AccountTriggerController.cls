public class AccountTriggerController {
    public static void AccountTriggerMethod(List<Account> newList){
        try{
            List<PermissionSetAssignment> perSet = [SELECT Id, PermissionSet.Name,AssigneeId FROM PermissionSetAssignment WHERE PermissionSet.Name = 'Account_Manager' AND AssigneeId=:UserInfo.getUserId()];
            System.debug('perSet'+perSet);
            if(!perSet.isEmpty()){
                List<Contact> conList = new List<Contact>();
                List<Contact> existingCon = [Select id,AccountId from Contact where AccountId IN:newList];
                for(Account acc : newList){
                    if(acc.Active__c == true && acc.Type == 'Customer - Direct'){
                        if(existingCon.isempty()){
                            Contact con = new Contact();
                            con.FirstName = acc.Name;
                            con.LastName = 'Customer Representative';
                            con.AccountId = acc.Id;
                            con.Email = acc.Company_Email__c;
                            con.Phone = acc.Phone;
                            conList.add(con);
                        }
                    }
                }
                if(!conList.isEmpty()){
                    insert conList;
                } 
            }
            else{
                for(Account ac:newList){
                    ac.addError('You do not have access');
                }
            }
        }
        Catch(Exception e){
            System.debug('Message'+e.getMessage() +'LineNumber'+ e.getLineNumber());
        }
    }
}