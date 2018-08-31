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
  /// Update event
  ///
  /// A document has been created/updated
  static const String updatee = "update";

  /// Delete event
  ///
  /// A document has been deleted
  static const String deletee = "delete";

  /// Decode error event
  ///
  /// The change notification received from CouchDB cannot be
  /// transformed into valid JSON, this may be a temporary issue,
  /// the client must decide whether to continue on or re-initialise
  /// the change notification class.
  static const String decodeErrorr = "decode";

  /// CouchDb error event
  ///
  /// The change notification received from CouchDB indicates an error.
  static const String couchdbError = "couch";

  /// Abort event
  ///
  /// A fatal error in the HTTP client has been detected, the client must
  /// assume that on receiving the event the change notification interface must
  /// be re-initialised.
  static const String abortt = "abort";

  /// Last sequence number event
  ///
  /// Sent by CouchDB when there are no changes, only the last sequence number is returned.
  ///
  static const String lastSequence = "sequence";

  /// Update event
  WiltChangeNotificationEvent.update(
      this._docId, this._docRevision, this._sequenceNumber,
      [this._document]) {
    _type = updatee;
  }

  /// Delete event
  WiltChangeNotificationEvent.delete(
      this._docId, this._docRevision, this._sequenceNumber) {
    _type = deletee;
  }

  /// Decode error event
  WiltChangeNotificationEvent.decodeError(
      this._httpResponseText, this._exception) {
    _type = decodeErrorr;
  }

  /// Abort event
  WiltChangeNotificationEvent.abort(this._exception) {
    _type = abortt;
  }

  /// CouchDB error event
  WiltChangeNotificationEvent.couchDbError(
      this._couchError, this._couchReason) {
    _type = couchdbError;
  }

  /// Sequence number event
  WiltChangeNotificationEvent.sequence(this._sequenceNumber) {
    _type = lastSequence;
  }

  /// Type
  ///
  /// Valid for all events
  String _type = null;
  String get type => _type;

  /// Sequence Number
  ///
  /// Valid for update, delete and sequence
  ///
  int _sequenceNumber = 0;

  int get sequenceNumber => _sequenceNumber;

  /// Document identifier
  ///
  /// Valid for update and delete
  String _docId = null;
  String get docId => _docId;

  /// Document revision
  ///
  /// Valid for update and delete but optional
  String _docRevision = null;
  String get docRevision => _docRevision;

  /// Document object
  ///
  /// Valid for update and only if includeDocs is true
  jsonobject.JsonObjectLite _document = null;

  jsonobject.JsonObjectLite get document => _document;

  /// Exception string
  ///
  /// Valid for abort and decode error
  String _exception = null;
  String get exception => _exception;

  /// HTTP response text
  ///
  /// Valid for decode error
  String _httpResponseText = null;
  String get httpResponseText => _httpResponseText;

  /// Couch error
  ///
  /// Valid for update and delete
  String _couchError = null;
  String get couchError => _couchError;

  /// Couch reason
  ///
  /// Valid for update and delete
  String _couchReason = null;
  String get couchReason => _couchReason;
}
