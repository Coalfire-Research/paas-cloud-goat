public with sharing class SOQLInjection3 {
    // BUG1337: Fixed the security audit finding by blindly adding "with sharing" everywhere. Hope appsec leaves me alone.

    public String query{get; set;} {query = getSampleQuery();}
    public String result{get;set;}

    public static String getSampleQuery() {
        // Work around  Error: Compile Error: The SOQL FIELDS function is not supported with an unbounded set of fields in this API. at line 9 column 32    
        List<String> fields = new List<String>(
            Schema.getGlobalDescribe().get('Building__c')
            .getDescribe()
            .fields.getMap().keySet()
            );
    
        return 'SELECT ' + String.join(fields, ',') + ' FROM Building__c';
    }

    public PageReference querySOQL() {
        //USER_MODE vs SYSTEM_MODE behaves different regardless of with or without sharing
        //https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_dynamic_soql.htm
        // The default is AccessLevel.SYSTEM_MODE
        List<sObject> listOfsObject = Database.query(this.query);

        // Mitigations you should see:
        // (newer) Database.query(this.query, AccessLevel.USER_MODE)
        //      https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_dynamic_soql.htm
        // (older) common method:
        //      https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_perms_enforcing.htm#topic-title
        /* if(
            Schema.sObjectType.Contact.fields.Email.isUpdateable()
            && Schema.sObjectType.Contact.fields.Email.isCreateable()
            && Schema.sObjectType.Contact.fields.Email.isAccessible()
            && Schema.sObjectType.Contact.isDeletable()
            ) { ...
        )
        */
        // Note that depending on the desired authZ the combo of fields above may be different

        result = String.join(listOfsObject, '\r\n');

        return null;  // Signal to return back to calling page
    }
}