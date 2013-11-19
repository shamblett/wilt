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
  
 
  /**
   * The method used 
   */
  String _method = null;
  
  /** 
   * All responses are JSON Objects 
   */
  jsonobject.JsonObject jsonResponse = new jsonobject.JsonObject();
  
  /** 
   * Completion callback 
   */
  var completion = null;
  
  /**
   *  Optional completer 
   */
  WiltNativeHTTPAdapter([this.completion]);
    
  /**
   *  All response headers 
   */
  String _allResponseHeaders = null;
  String get responseHeaders => _allResponseHeaders;
 
  /**
   * Error completion
   */
  void onError(html.ProgressEvent response){
    
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
    _allResponseHeaders = req.getAllResponseHeaders();
    
    /**
     * Call the completer, in an error condition we might not get to
     * whenComplete on the request
     */
    completion;
   
  }
  
  /**
   * Successful completion
   */
  void onSuccess(html.HttpRequest response){
    
    /**
     *  Process the success response, note that an error response from CouchDB is 
     *  treated as an error, not as a success with an 'error' field in it.
     */
    jsonResponse.error = false;
    jsonResponse.errorCode = 0;
    jsonResponse.responseText = response.responseText;
    var couchResp;
    try {
      
      couchResp = JSON.decode(response.responseText);
    
    } catch (e) {
      
      jsonResponse.error = true;
      jsonobject.JsonObject errorAsJson = new jsonobject.JsonObject();
      errorAsJson.error = "JSON Decode Error";
      errorAsJson.reason = "None";
      jsonResponse.jsonCouchResponse = errorAsJson;
      /* Set the response headers */
      _allResponseHeaders = response.getAllResponseHeaders();
      return;
      
    }
    
    
    if ( (couchResp is Map) && (couchResp.containsKey('error')) ) {
      
      jsonResponse.error = true;
      jsonobject.JsonObject errorAsJson = new jsonobject.JsonObject();
      errorAsJson.error = "CouchDb Error";
      errorAsJson.reason = couchResp['reason'];
      jsonResponse.jsonCouchResponse = errorAsJson;
      /* Set the response headers */
      _allResponseHeaders = response.getAllResponseHeaders();
      return;
      
    }
    
    /**
     * Success response
     */
    if ( _method != 'HEAD') {
      jsonobject.JsonObject successAsJson = new jsonobject.JsonObject.fromJsonString(response.responseText);
      jsonResponse.jsonCouchResponse = successAsJson;
    }  
    /* Set the response headers */
    _allResponseHeaders = response.getAllResponseHeaders();
    
  }
  
   
  /**
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
