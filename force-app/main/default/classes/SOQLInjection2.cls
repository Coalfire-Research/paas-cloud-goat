public without sharing class SOQLInjection2 {
    // Observe the above change

    public String queryType{get; set;} {queryType = 'Contact';}
    public String result{get;set;}

    public List<SelectOption> getQueries() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Contact','[SELECT id,Name FROM Contact]'));
        options.add(new SelectOption('Building','[SELECT id,Name FROM Building__c]'));
        
        return options;
    }

    public PageReference querySOQL() {
        List<sObject> listOfsObject;
        if('Contact'.equals(queryType)) {
            listOfsObject = [SELECT id,Name FROM Contact];
        } else {
            listOfsObject = [SELECT id,Name FROM Building__c];
        }

        result = String.join(listOfsObject, '\r\n');

        return null;  // Signal to return back to calling page
    }
}