public without sharing class SOSL2 {
    public String searchTerm{get; set;} {searchTerm = 'Andy Young';}
    public String searchFilter{get; set;} {searchFilter = 'CreatedDate > LAST_YEAR';}

    public PageReference querySOSL() {
        // An external security pen test said I had to fix the vulnerability
        // I just did a web search and found this example on http://dev-forums.scatter-underflow.tld/ which made the SAST pass
        String query = 'FIND {' 
            + String.escapeSingleQuotes(this.searchTerm) 
            + '} '
            + 'IN ALL FIELDS '
            + 'RETURNING '
            //TODO, fixme: + 'Contact (Id, Name WHERE ' + String.escapeSingleQuotes(this.searchFilter) + '), '
              + 'Contact,'
            + 'Building__c (Id, Name WHERE ' + String.escapeSingleQuotes(this.searchFilter) + ')';

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