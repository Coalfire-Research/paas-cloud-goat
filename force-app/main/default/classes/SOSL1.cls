public without sharing class SOSL1 {
    public String searchTerm{get; set;} {searchTerm = 'Ja*';}

    public PageReference querySOSL() {
        // Re-used John's other code, thanks for the copy+pasta
        String query = 'FIND {' + this.searchTerm + '} IN ALL FIELDS RETURNING Contact (Id, Name), Building__c';

        if(easymode) {
            result = 'EASY MODE ENABLED:\r\n';
            result += query + '\r\n\r\n';
        } else {
            result = '';
        }
        
        List<List <sObject>> searchResults;
        
        try {
            searchResults = search.query(query);
            for(List <sObject> sobjects : searchResults) {
                result += String.join(sobjects, '\r\n');
            }
        } catch (Exception e) {
            System.debug(e);
            if(easymode) {
                result += e;
            }
        }

        

        return null;  // Signal to return back to calling page
    }

    public Boolean easymode{get; set;} {easymode = false;}
    public String result{get;set;}
}