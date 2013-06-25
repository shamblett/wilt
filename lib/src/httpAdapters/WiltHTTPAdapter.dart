/*
 * Packge : Wilt
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 04/06/2013
 * Copyright :  S.Hamblett@OSCF
 *
 * Provides a common interface for Wilt to connect over HTTP,
 * allowing for different HTTP adapters to be used. 
 */

part of wilt;

abstract class WiltHTTPAdapter {
  
  
  WiltHTTPAdapter();
  
  
  /*
   * Processes the HTTP request returning the server's response as
   * a JSON Object
   */
  void httpRequest(String method, 
                   String url, 
                   [String data = null,
                   Map headers = null]);
  
  /*
   * Result Handling
   */
  void onError(html.HttpRequestProgressEvent response);
  void onSuccess(html.HttpRequest response);
  
}