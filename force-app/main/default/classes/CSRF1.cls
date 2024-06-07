public with sharing class CSRF1 {
    public void init() {
        if(String.isBlank(ApexPages.currentPage().getParameters().get('id'))) {
            return;
        }
        
        Id id = ApexPages.currentPage().getParameters().get('id');
        System.debug(id);

        Contact obj = [select id, Name FROM Contact WHERE id = :id]; 
        System.debug(obj);
        
        String newname = ApexPages.currentPage().getParameters().get('newname'); 
        System.debug(newname);

        obj.FirstName = newname;

        update obj;

        return;
    }


    public Id getFirstContactID() {
        // Not ordered by name but internal creation
        Contact obj = [select id FROM Contact LIMIT 1];

        return obj.id;
    }
}