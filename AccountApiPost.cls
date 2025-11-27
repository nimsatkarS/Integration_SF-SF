public class AccountApiPost {

    public AccountApiPost() {

        Http http = new Http();                     // Create HTTP object
        HttpRequest req = new HttpRequest();        // Prepare HTTP request

        req.setEndpoint('https://login.salesforce.com/services/oauth2/token');  
        // OAuth token URL

        req.setMethod('POST');                      // POST request
        req.setHeader('Content-Type','application/x-www-form-urlencoded'); 
        // Request body type

        // OAuth request body with username-password flow
        String reqBody ='grant_type=password&client_id=YOURCLIENTID&client_secret=CLIENT SECRET KEY&username=YOURUSERNAME@agentforce.com&password=YOURPASSWORD+YOURTOKEN';

        req.setBody(reqBody);                       // Attach body

        HttpResponse res = http.send(req);          // Send request
        String rBody = res.getBody();               // Get response body

        system.debug('Response--' + rBody);         // Print response body
        system.debug(res);                          // Print full response
    }
}
