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

  /* Exception message strings */
  static const HEADER = 'WiltException: ';
  static const NO_DATABASE_SPECIFIED = 'No database specified';
  static const GET_DOC_NO_ID = 'getDocument() must have a document id';
  static const DELETE_DOC_NO_ID_REV =
      'deleteDocument() expects a document id and a revision';
  static const PUT_DOC_NO_ID_BODY =
      'putDocument() expects a document id and a document body';
  static const PUT_DOC_CANT_STRINGIFY =
      'putDocument() cannot stringify the document body, use putDocumentString';
  static const PUT_DOC_STRING_NO_ID_BODY =
      'putDocumentString() expects a document id and a document body';
  static const POST_DOC_NO_BODY = 'postDocument() expects a document body';
  static const POST_DOC_CANT_STRINGIFY =
      'postDocument() cannot stringify document body , use postDocumentString';
  static const POST_DOC_STRING_NO_BODY =
      'postDocumentString() expects a document body';
  static const COPY_DOC_NO_SRC_ID = 'copyDocument () expects a source id';
  static const COPY_DOC_NO_DEST_ID = 'copyDocument () expects a destination id';
  static const GET_ALL_DOCS_LIMIT = 'getAllDocs() must have a positive limit';
  static const BULK_NO_DOC_LIST = 'bulk() must have a document list';
  static const BULK_CANT_STRINGIFY =
      'bulk() cannot stringify document list, use bulkString';
  static const BULK_STRING_NO_DOC = 'bulkString() must have a document string';
  static const CREATE_DB_NO_NAME = 'createDatabase() expects a database name';
  static const DELETE_DB_NO_NAME = 'deleteDatabase() expects a database name';
  static const CREATE_ATT_NO_DOC_ID =
      'createAttachment() expects a document id';
  static const CREATE_ATT_NO_NAME =
      'createAttachment() expects an attachment name';
  static const CREATE_ATT_NO_REV = 'createAttachment() expects a revision';
  static const CREATE_ATT_NO_CONTENT_TYPE =
      'createAttachment() expects a content type';
  static const CREATE_ATT_NO_PAYLOAD = 'createAttachment() expects a payload';
  static const UPDATE_ATT_NO_DOC_ID =
      'updateAttachment() expects a document id';
  static const UPDATE_ATT_NO_NAME =
      'updateAttachment() expects an attachment name';
  static const UPDATE_ATT_NO_REV = 'updateAttachment() expects a revision';
  static const UPDATE_ATT_NO_CONTENT_TYPE =
      'updateAttachment() expects a content type';
  static const UPDATE_ATT_NO_PAYLOAD = 'updateAttachment() expects a payload';
  static const DELETE_ATT_NO_DOC_ID =
      'deleteAttachment() expects a document id';
  static const DELETE_ATT_NO_NAME =
      'deleteAttachment() expects an attachment name';
  static const DELETE_ATT_NO_REV = 'deleteAttachment() expects a revision';
  static const GET_ATT_NO_DOC_ID = 'getAttachment() expects a document id';
  static const GET_ATT_NO_NAME = 'getAttachment() expects an attachment name';
  static const UPDATE_CNP_NO_PARAMS =
      'updateChangeNotificationParameters() expects a parameter set';
  static const UPDATE_CNP_NO_NOTIFIER =
      'updateChangeNotificationParameters() no change notifier';
  static const LOGIN_WRONG_PARAMS =
      'Login() expects a non null user name and password';
  static const GEN_IDS_AMOUNT = 'generateIds() expects a positive amount';
  static const BAD_CONST_PARAMS =
      'Bad construction - some or all required parameters are null';
  static const BAD_CONST_NO_ADAPTER =
      'Bad construction - you must instantiate Wilt with a HTTP Adapter';
  static const CN_NO_AUTH = "Change Notifications must be authorized";

  /* Construction */
  String _message = 'No Message Supplied';
  WiltException([this._message]);

  String toString() => HEADER + "${_message}";
}
