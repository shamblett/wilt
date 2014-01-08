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
 * When destroyed, change notification ceases
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
  
  WiltChangeNotification([this._dbName,
                          this._parameters]) {
    
    
    
  }
                          
}