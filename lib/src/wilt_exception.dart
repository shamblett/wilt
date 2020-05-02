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

/// Exceptions
class WiltException implements Exception {
  // Construction
  WiltException([this._message = 'No Message Supplied']);

  // Exception message strings
  static const String header = 'WiltException: ';
  static const String noDatabaseSpecified = 'No database specified';
  static const String getDocNoId = 'getDocument() must have a document id';
  static const String getDocRevNoId =
      'getDocumentRevision() must have a document id';
  static const String deleteDocNoIdRev =
      'deleteDocument() expects a document id and a revision';
  static const String putDocNoIdBody =
      'putDocument() expects a document id and a document body';
  static const String putDocCantStringify =
      'putDocument() cannot stringify the document body, use putDocumentString';
  static const String putDocStringNoIdBody =
      'putDocumentString() expects a document id and a document body';
  static const String postDocNoBody = 'postDocument() expects a document body';
  static const String postDocCantStringify =
      'postDocument() cannot stringify document body , use postDocumentString';
  static const String postDocStringNoBody =
      'postDocumentString() expects a document body';
  static const String copyDocNoSrcId = 'copyDocument () expects a source id';
  static const String copyDocNoDestId =
      'copyDocument () expects a destination id';
  static const String getAllDocsLimit =
      'getAllDocs() must have a positive limit';
  static const String bulkNoDocList = 'bulk() must have a document list';
  static const String bulkCantStringify =
      'bulk() cannot stringify document list, use bulkString';
  static const String bulkStringNoDoc =
      'bulkString() must have a document string';
  static const String createDbNoName =
      'createDatabase() expects a database name';
  static const String deleteDbNoName =
      'deleteDatabase() expects a database name';
  static const String createAttNoDocId =
      'createAttachment() expects a document id';
  static const String createAttNoName =
      'createAttachment() expects an attachment name';
  static const String createAttNoRev = 'createAttachment() expects a revision';
  static const String createAttNoContentType =
      'createAttachment() expects a content type';
  static const String createAttNoPayload =
      'createAttachment() expects a payload';
  static const String updateAttNoDocId =
      'updateAttachment() expects a document id';
  static const String updateAttNoName =
      'updateAttachment() expects an attachment name';
  static const String updateAttNoRev = 'updateAttachment() expects a revision';
  static const String updateAttNoContentType =
      'updateAttachment() expects a content type';
  static const String updateAttNoPayload =
      'updateAttachment() expects a payload';
  static const String deleteAttNoDocId =
      'deleteAttachment() expects a document id';
  static const String deleteAttNoName =
      'deleteAttachment() expects an attachment name';
  static const String deleteAttNoRev = 'deleteAttachment() expects a revision';
  static const String getAttNoDocId = 'getAttachment() expects a document id';
  static const String getAttNoName =
      'getAttachment() expects an attachment name';
  static const String updateCnpNoParams =
      'updateChangeNotificationParameters() expects a parameter set';
  static const String updateCnpNoNotifier =
      'updateChangeNotificationParameters() no change notifier';
  static const String loginWrongParams =
      'Login() expects a non null user name and password';
  static const String genIdsAmount = 'generateIds() expects a positive amount';
  static const String badConstParams =
      'Bad construction - some or all required parameters are null';
  static const String badConstNoAdapter =
      'Bad construction - you must instantiate Wilt with a HTTP Adapter';
  static const String cnNoAuth = 'Change Notifications must be authorized';

  final String _message;

  @override
  String toString() => '$header$_message';
}
