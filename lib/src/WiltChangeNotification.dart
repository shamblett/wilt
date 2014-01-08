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
 * The resulting notifications are turned into notification classes and streamed to
 * the notification consumer. 
 * 
 * CouchDb is initialized to supply the change notification stream as a continuous stream
 * with regular heartbeats
 */

part of wilt;

class WiltChangeNotification {
  
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
  
  WiltChangeNotification(this._host,
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
                   "&limit=${_parameters.limit}"+
                   "&descending=${_parameters.descending}"+
                   "&include_docs=${_parameters.includeDocs}";
                   
    String url = "$_scheme$_host:${_port.toString()}/$path";
    
    /**
     * Open the request
     */
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
         * Just report this for now
         */
        print( "WiltChangeNotification::MonitorChanges JSON decode fail ${e.toString()}");
        
      }
      
    });
    
    /**
     * Listener for errors
     */
    _client.onError.listen((event) {
      
      /**
       * Just report this for now
       */
      print( "WiltChangeNotification::MonitorChanges HTTP Error Status code is ${_client.status}");
      print( "WiltChangeNotification::MonitorChanges HTTP Error Status text is ${_client.statusText}");
      
    });
    
    /**
     * Send the request
     */
    _client.send();
      
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