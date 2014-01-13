/*
 * Packge : Wilt
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 04/06/2013
 * Copyright : S.Hamblett@OSCF
 *
 * Change notification event
 * 
 * The type property of this class determines the validity of the rest of the
 * class data, see individual properties for this mapping. Uers should check the 
 * event type property BEFORE accessing any other property.
 * 
 * See each event below for a description of its effect.
 * 
 */

part of wilt;

class WiltChangeNotificationEvent {
  
  /**
   * Update event
   * 
   * A document has been created/updated
   */
  static const String UPDATE = "update";
  
  /**
   * Delete event
   * 
   * A document has been deleted
   */
  static const String DELETE = "delete";
  
  /**
   * Decode error event
   * 
   * The change notification recieved from CouchDB cannot be 
   * transformed into valid JSON, this may be a temporary issue,
   * the client must decide whether to continue on or re-initialise
   * the change notification class.
   */
  static const String DECODE_ERROR = "decode";
  
  /**
   * CouchDb error event
   * 
   * The change notification recieved from CouchDB indicates an error.
   */
  static const String COUCHDB_ERROR = "couch";
  
  /**
   * Abort event
   * 
   * A fatal error in the HTTP client has been detected, the client must
   * assume that on recieveing the event the change notification interface must
   * be re-initialised.
   */
  static const String ABORT = "abort";
  
  /**
   * Type
   * 
   * Valid for all events
   */
  String _type = null;
  String get type => _type;
  
  /**
   * Sequence Number
   * 
   * Valid for update and delete
   */
  int _sequenceNumber = 0;
  int get sequenceNumber => _sequenceNumber;
  
  /**
   * Document identifier
   * 
   * Valid for update and delete
   */
  String _docId = null;
  String get docId => _docId;
  
  /**
   * Document revision
   * 
   * Valid for update and delete but optional
   */
  String _docRevision = null;
  String get docRevision => _docRevision;
  
  /**
   * Document object
   * 
   * Valid for update and only if includeDocs is true
   */
  jsonobject.JsonObject _document = null;
  jsonobject.JsonObject get  document => _document;
  
  /**
   * Exception string
   * 
   * Valid for abort and decode error
   */
  String _exception = null;
  String get exception => _exception;
  
  /**
   * HTTP response text
   * 
   * Valid for decode error
   */
  String _httpResponseText = null;
  String get httpResponseText => _httpResponseText;
  
  /**
   * Couch error
   * 
   * Valid for update and delete
   */
  String _couchError = null;
  String get couchError => _couchError;
  
  /**
   * Couch reason
   * 
   * Valid for update and delete
   */
  String _couchReason = null;
  String get couchReason => _couchReason;
  
  WiltChangeNotificationEvent.update(this._docId,
                                     this._docRevision,
                                     this._sequenceNumber,
                                     [this._document]);
  
  WiltChangeNotificationEvent.delete(this._docId,
                                     this._docRevision,
                                     this._sequenceNumber);
  
  
  WiltChangeNotificationEvent.decodeError(this._httpResponseText,
                                          String exception);
  
  WiltChangeNotificationEvent.abort(String exception);
  
  WiltChangeNotificationEvent.couchDbError(this._couchError,
                                           this._couchReason);
  
}