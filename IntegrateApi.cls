public class IntegrateApi {
    public IntegrateApi() {

        //using Custom Metadata Type to store sensitive information 
        RequestBody__mdt test =  RequestBody__mdt.getInstance('AccountApi');
       	string requestBody ='grant_type=password&client_id='+ test.client_id__c + 
            				'&client_secret='+ test.client_secret__c + 
            				'&username='+ test.username__c + 
            				'&password='+ test.password__c;


        Http http = new Http();                     // Create HTTP object
        HttpRequest req = new HttpRequest();        // Prepare HTTP request

        req.setEndpoint('https://login.salesforce.com/services/oauth2/token');  
        // OAuth token URL

        req.setMethod('POST');                      // POST request
        req.setHeader('Content-Type','application/x-www-form-urlencoded'); 
        // Request body type

        req.setBody(requestBody);                // Attach body 
        HttpResponse res = http.send(req);       // Send request
        String rBody = res.getBody();            // Get response body
        system.debug('res---'+res.getBody());    // Print response body
        system.debug(res);                       // Print full response

        HttpResponse res = http.send(req);          // Send request
        String rBody = res.getBody();               // Get response body

        system.debug('Response--' + rBody);         // Print response body
        system.debug(res);                          // Print full response
    }
}