/*
 * Packge : Wilt
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 04/06/2013
 * Copyright : S.Hamblett@OSCF
 *
 * Change notification event
 * 
 */

part of wilt;

class WiltChangeNotificationEvent {
  
  /**
   * Update event
   */
  static const String UPDATE = "update";
  
  /**
   * Delete event
   */
  static const String Delete = "delete";
  
  /**
   * Decode error event
   */
  static const String DECODE_ERROR = "decode";
  
  /**
   * Abort event
   */
  static const String ABORT = "abort";
  
  /**
   * Type
   * Valid for all events
   */
  String _type = null;
  String get type => _type;
  
  /**
   * Document identifier
   * Valid for update and delete
   */
  String _docId = null;
  String get docId => _docId;
  
  /**
   * Document revision
   * Valid for update and delete
   */
  String _docRevision = null;
  String get docRevision => _docRevision;
  
  /**
   * HTTP status code
   * Valid for abort
   */
  int _httpStatus = 0;
  int get httpStatus => _httpStatus;
  
  /**
   * HTTP reason text
   * Valid for abort
   */
  String _httpReason = null;
  String get httpReason => _httpReason;
  
  /**
   * HTTP response text
   * Valid for decode error
   */
  String _httpResponseText = null;
  String get httpResponseText => _httpResponseText;
  
  
}