public with sharing class WrapperIntegrate {

    public static OAuthTokenResponse WrapperIntegrate() {
               //using the METADATA cocnc   
            RequestBody__mdt test =  RequestBody__mdt.getInstance('AccountApi');
       	    string requestBody ='grant_type=password&client_id='+ test.client_id__c + 
            				    '&client_secret='+ test.client_secret__c + 
            				    '&username='+ test.username__c + 
            				    '&password='+ test.password__c;
        
        Http http = new Http();
        HttpRequest req = new HttpRequest();
    	req.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        req.setMethod('POST');
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        req.setBody(requestBody);

        HttpResponse res = http.send(req);
        String rBody = res.getBody();
        system.debug('res---'+res.getBody());
        system.debug(res);
        
        OAuthTokenResponse wrap = (OAuthTokenResponse) JSON.deserialize(rBody,OAuthTokenResponse.class);
        system.debug('--Wrap-access_token---'+wrap.access_token);
        system.debug('--Wrap-instance_url-'+wrap.instance_url);
        system.debug('--Wrap-token_type--'+wrap.token_type);
        system.debug('--Wrap-id-'+wrap.id);
        system.debug('--Wrap-issued_at--'+wrap.issued_at);
        system.debug('--Wrap-signature--'+wrap.signature);
        system.debug('--Wrap--'+wrap);
        
        return wrap;
    }
    
    //WRAPPER 
    public class OAuthTokenResponse{
    	public String access_token;
    	public String instance_url;
    	public String id;
    	public String token_type;
    	public String issued_at;
    	public String signature;
    }
    
    //Fetch the Account Detail
    public static void grtAccount(){
        OAuthTokenResponse recivedWrap = getToken();
        Http http = new Http();
        HttpRequest reqAcc = new HttpRequest();
        reqAcc.setMethod('GET');
        reqAcc.setEndPoint(recivedWrap.instance_url+'/services/apexrest/getAccountDetailFromReceiver');
        reqAcc.setHeader('Content-Type','application.json');
        reqAcc.setHeader('Authorization','Bearer '+recivedWrap.access_token);
   		
        HttpResponse rs = http.send(reqAcc);
        System.debug('account response:'+rs);
        System.debug('account response body:'+rs.getBody());
    }
}