/*
 * Packge : Wilt
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 07/01/2014
 * Copyright :  S.Hamblett@OSCF
 *
 * Change notification control class
 * 
 * This class when constructed initiates change notification processing with either
 * a default set of change notification parameters or one supplied by the client.
 * When destroyed, change notification ceases.
 * 
 * 
 * The resulting notifications are turned into notification events and streamed to
 * the notification consumer. See the WiltChangeNotificationEvent class for further details.
 * 
 * The 'limit' parameter of the CouchDB request is set to 1 so as to allow only one
 * change notification to be recieved at a time.
 * 
 * CouchDb is initialized to supply the change notification stream as a continuous stream
 * with regular heartbeats.
 */

part of wilt;

class _WiltChangeNotification {
  
  /**
   * Parameters set
   */
  WiltChangeNotificationParameters  _parameters = null;
  
  /**
   * Database name
   */
  String _dbName = null;
  
  /** 
   * Host name
   */
  String _host = null;  
  
  /** 
   * Port number
   */
  String _port = null; 
  
  /** 
   * HTTP scheme
   */
  String _scheme = null; 
  
  /**
   * HTTP client
   */ 
  html.HttpRequest _client = null;
  
  _WiltChangeNotification(this._host,
                         this._port,
                         this._scheme,
                         [this._dbName,
                          this._parameters]) {
    
    
    if ( _parameters == null ) {
      
      _parameters = new WiltChangeNotificationParameters();
      
    }
    
    monitorChanges();
    
  }
  
  /**
   * Monitor CouchDB in continous mode with a heartbeat
   */
  void monitorChanges() {
    
    /**
     * Create the URL from the parameters
     */
    String path = "$_dbName/_changes?"+
                   "feed=continuous"+
                   "&heartbeat=${_parameters.heartbeat}"+
                   "&since=${_parameters.since}"+
                   "&limit=1"+
                   "&descending=${_parameters.descending}"+
                   "&include_docs=${_parameters.includeDocs}";
                   
    String url = "$_scheme$_host:${_port.toString()}/$path";
    
    /**
     * Open the request
     */
    try {
      
      _client.open('GET', url);
    
      /**
      * Listener for changes
      */
      _client.onLoad.listen((event) {
      
        String response = _client.responseText;
      
        /**
        * Ignore heartbeat responses
        */
        if ( response.length == 1 ) return;
      
        /**
        * Proces the change notification
        */
        try {
        
          Map dbChange = JSON.decode(response);
          processDbChange(dbChange);
        
        } catch (e) {
        
          /**
          * Recoverable error, send the client an error event
          */
          print( "WiltChangeNotification::MonitorChanges JSON decode fail ${e.toString()}");
        
        }
      
      });
    
      /**
      * Listener for errors
      */
      _client.onError.listen((event) {
      
        /**
        * Unrecoverable error, send the client an abort event
        */
        print( "WiltChangeNotification::MonitorChanges HTTP Error Status code is ${_client.status}");
        print( "WiltChangeNotification::MonitorChanges HTTP Error Status text is ${_client.statusText}");
      
      });
    
      /**
      * Send the request
      */
      _client.send();
      
    } catch (e) {
      
      /**
       * Unrecoverable error, send the client an abort event
       */
      print("WiltChangeNotification::MonitorChanges unable to contact CouchDB Error is ${e.ToString()}");
      
      
    }
      
  }
  
  
  /**
   * Database change update
   */
  void processDbChange(Map change ) {
      
    Map document = change['doc'];
    if ( !change.containsKey('deleted') ) {  
   
      
    } else {
      
      
    }
    
  }
  
                          
}