@IsTest
public class AccountTriggerControllerTest {
    @IsTest
    static void givenAccount_whenActiveAccountCreated_thenThrowError(){
        Profile stdProfile = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User stdUser = new User(Alias = 'standt', Email='standarduser@testorg.com', 
                                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                                LocaleSidKey='en_US', ProfileId = stdProfile.Id, 
                                TimeZoneSidKey='America/Los_Angeles', UserName='123_standarduser@testorg.com');
        insert stdUser;
        PermissionSet per = [Select id,Name from PermissionSet where Name = 'Account_Manager'];
        PermissionSetAssignment psa = new PermissionSetAssignment (PermissionSetId = per.Id, AssigneeId = stdUser.Id);
        insert psa;
        System.runAs(stdUser){
            Account acc = new Account();
            acc.Name = 'test';
            acc.Active__c = true;
            acc.Type = 'Customer - Direct';
            insert acc;
            List<Account> accounts = [SELECT Id FROM Account];
            System.debug('accounts: '+accounts);
            System.assertEquals(true, accounts.size() == 1, 'account should be inserted');
        }
        
    }
    
    @IsTest
    static void givenAccount_whenActiveAccountCreated_thenThrowErrorIfAccountManagerPermissionSetNotAssigned(){
        Profile stdProfile = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User stdUser = new User(Alias = 'standt', Email='standarduser@testorg.com', 
                                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                                LocaleSidKey='en_US', ProfileId = stdProfile.Id, 
                                TimeZoneSidKey='America/Los_Angeles', UserName='123_standarduser@testorg.com');
        insert stdUser;
        System.runAs(stdUser){
            Account acc = new Account();
            acc.Name = 'test';
            acc.Active__c = true;
            acc.Type = 'Customer - Direct';
            Database.insert (acc,false);
            List<Account> accounts = [SELECT Id FROM Account];
            System.debug('accounts: '+accounts);
            System.assertEquals(true, accounts.size() == 0, 'No account should be inserted');
        }
    }
}