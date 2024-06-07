public with sharing class SOQLInjection4 {  // We also borrow this for XSS examples
    public String sortDirection{get; set;} {sortDirection = 'ASC';}
    public List<Contact> contacts{get; private set;} {contacts = Database.query('SELECT id,Name,Title,Phone FROM Contact ORDER BY Name ASC');}

    public PageReference querySOQL() {
        String query = 'SELECT id,Name,Title,Phone FROM Contact ORDER BY Name ' + sortDirection;  // Very common way to code this

        if(easymode) {
            result = 'EASY MODE ENABLED:\r\n';
            result += query + '\r\n\r\n';
        } else {
            result = '';
        }
        
        this.contacts = Database.query(query);  // What was that default AccessLevel again?

        return null;  // Signal to return back to calling page
    }

    public Boolean easymode{get; set;} {easymode = false;}
    public String result{get;set;}
}