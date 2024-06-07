public with sharing class SOQLInjection1 {


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
        List<sObject> listOfsObject = Database.query(this.query, AccessLevel.USER_MODE);

        result = String.join(listOfsObject, '\r\n');

        return null;  // Signal to return back to calling page
    }
}