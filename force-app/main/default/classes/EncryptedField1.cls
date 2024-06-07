public without sharing class EncryptedField1 {
    public List<SecretSauce__c> getSecretSauce() {
        return Database.query('SELECT Id,Name,PublicSize__c,SecretIngredient__c FROM SecretSauce__c', AccessLevel.SYSTEM_MODE);
    }
}