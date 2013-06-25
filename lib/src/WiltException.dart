/*
 * Packge : Wilt
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 04/06/2013
 * Copyright :  S.Hamblett@OSCF
 *
 * This exception is thrown when Wilt has an internal error, such as an invalid
 * parameter being passed to a function.
 */

part of wilt;

class WiltException implements Exception {
  String _message = 'No Message Supplied';
  WiltException([this._message]);
  
  String toString() => "WiltException: message = ${_message}";
}

