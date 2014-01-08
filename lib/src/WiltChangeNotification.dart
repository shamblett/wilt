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
 */

part of wilt;

class WiltChangeNotification {
  
  /**
   * Parameters set
   */
  WiltChangeNotificationParameters  _parameters = new WiltChangeNotificationParameters();
  
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
    
    
    
  }
                          
}