public with sharing class SOQLInjection5 {
    public String tableName{get; set;} {tableName = 'Contact';}
    public String searchTerm{get; set;} {searchTerm = '%J%';}

    public PageReference querySOQL() {
        String query = 'SELECT id,Name FROM ' + this.tableName + ' WHERE Name LIKE :searchTerm';

        if(easymode) {
            result = 'EASY MODE ENABLED:\r\n';
            result += query + '\r\n\r\n';
        } else {
            result = '';
        }
        
        List<sObject> listOfsObject = Database.query(query);  // What was that default AccessLevel again?

        result += String.join(listOfsObject, '\r\n');

        return null;  // Signal to return back to calling page
    }

    public Boolean easymode{get; set;} {easymode = false;}
    public String result{get;set;}
}