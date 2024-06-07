public without sharing class XML1 {
    public String retrievalUrl{get; set;} {
        StaticResource sr_xmlstatic_resource = [SELECT Id FROM StaticResource WHERE Name = 'xml_xxe_xml' LIMIT 1];
        
        String relative = '/resource/' + sr_xmlstatic_resource.get('Name');
        PageReference pageReference = new PageReference(relative);

        retrievalUrl = pageReference.getContent().toString();
    }

    public PageReference parse() {
        if( String.isBlank(this.retrievalUrl) ) {
            this.result = 'No URL specified';
        } else {
            this.result = 'Parsing ' + this.retrievalUrl;
        }

        // Variant from https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_xml_dom.htm
        //  2024-05-13
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        // url that returns the XML in the response body
        req.setEndpoint(this.retrievalUrl);
        req.setMethod('GET');
        HttpResponse res = h.send(req);
        Dom.Document doc = res.getBodyDocument();
        
        //Retrieve the root element for this document.
        Dom.XMLNode rootNode = doc.getRootElement();
        this.result =+ 'Root:\t' + rootNode;

        for(Dom.XMLNode child : rootNode.getChildElements()) {
            System.debug(child.getText());

            this.result =+ 'Child:\t' + child.getText();
         }

        return null;  // Signal to return back to calling page
    }

    public String result{get;set;}
}