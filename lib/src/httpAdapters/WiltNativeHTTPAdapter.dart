/*
 * Packge : Wilt
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 04/06/2013
 * Copyright :  S.Hamblett@OSCF
 *
 * Native CouchDB HTTP adapter for Wilt.
 *  
 * This always returns a JSON Object for use by the completion function.
 * 
 * The format of the JSON Object returned is as follows :-
 * 
 * error              : true if an error has occured, false otherwise
 * responseText       : the response text from HTTP
 * errorCode          : the status code from HTTP
 * jsonCouchResponse  : The responseText from CouchDB as a JSON Object,
 *                      this should be interpreted by the caller depending
 *                      on the request issued,refer to the CouchDB documentation.
 *                      
 */

part of wilt;

class WiltNativeHTTPAdapter implements WiltHTTPAdapter {
  
 
  /* The method used */
  String _method = null;
  
  /* All responses are JSON Objects */
  jsonobject.JsonObject jsonResponse = new jsonobject.JsonObject();
  
  /* Completion callback */
  var completion = null;
  
 /* Optional completer */
  WiltNativeHTTPAdapter([this.completion]);
    
  /* All response headers */
  String allResponseHeaders = null;
 
  /*
   * We get an HttpRequestProgressEvent on error and process this
   * to return a JSON Object.
   * 
   */
  void onError(html.HttpRequestProgressEvent response){
    
    /* Get the HTTP request from the progress event */
    html.HttpRequest req = response.target;
    
    /* Process the error response */
    jsonResponse.error = true;
    jsonResponse.responseText = req.responseText;
    jsonResponse.errorCode = req.status;
    if ( (req.status != 0)  && (_method != 'HEAD') ) {
      jsonobject.JsonObject errorAsJson = new jsonobject.JsonObject.fromJsonString(req.responseText);
      jsonResponse.jsonCouchResponse = errorAsJson;
    } else {
      jsonobject.JsonObject errorAsJson = new jsonobject.JsonObject();
      errorAsJson.error = "Invalid HTTP response";
      errorAsJson.reason = "HEAD or status code of 0";
      jsonResponse.jsonCouchResponse = errorAsJson;
    }
    
    /* Set the response headers */
    allResponseHeaders = req.getAllResponseHeaders();
  }
  
  /**
   * Successful completion
   */
  void onSuccess(html.HttpRequest response){
    
    /* Process the success response */
    jsonResponse.error = false;
    jsonResponse.responseText = response.responseText;
    if ( _method != 'HEAD') {
      jsonobject.JsonObject successAsJson = new jsonobject.JsonObject.fromJsonString(response.responseText);
      jsonResponse.jsonCouchResponse = successAsJson;
    }
    jsonResponse.errorCode = null;
    
    /* Set the response headers */
    allResponseHeaders = response.getAllResponseHeaders();
    
  }
  
   
  /*
   * Processes the HTTP request, returning the server's response
   * via the completion callback.
   */
  void httpRequest(String method, 
                   String url, 
                   [String data = null,
                   Map headers = null]) {
    
     
     /* Initialise */
     jsonResponse.error = null;
     jsonResponse.successText = null;
     jsonResponse.errorText = null;
     jsonResponse.errorCode = null;
     _method = method;
    
    /* Query couchdb over HTTP */ 
    html.HttpRequest.request(url,
                        method:method,
                        withCredentials:false,
                        responseType:null,
                        requestHeaders:headers,
                        sendData:data
        
        )
        ..then(onSuccess)
        ..catchError(onError)
        ..whenComplete(completion);
    
  }
  
  
}
