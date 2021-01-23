/*
 * Packge : Wilt
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 04/06/2013
 * Copyright :  S.Hamblett@OSCF
 *
 * This class provides Wilt user utility functions 
 */

part of wilt;

/// User utilities
class WiltUserUtils {
  /// Get a document id from a json Object
  static String? getDocumentId(jsonobject.JsonObjectLite<dynamic> response) {
    response.isImmutable = false;
    return response['_id'];
  }

  /// Get a revision from a json object
  static String? getDocumentRev(jsonobject.JsonObjectLite<dynamic> response) {
    response.isImmutable = false;
    if (response.containsKey('_rev')) {
      // Use this first if present
      return response['_rev'];
    } else {
      return response['rev'];
    }
  }

  /// Adds a CouchDB _rev to the json body of a document
  static String addDocumentRev(
      jsonobject.JsonObjectLite<dynamic> document, String? revision) {
    document.isImmutable = false;
    document['_rev'] = revision;
    return json.encode(document);
  }

  /// Adds a CouchDB _id to the json body of a document
  static String addDocumentId(
      jsonobject.JsonObjectLite<dynamic> document, String id) {
    document.isImmutable = false;
    document['_id'] = id;
    return json.encode(document);
  }

  /// Adds a CouchDB _rev to the json body of a document
  static jsonobject.JsonObjectLite<dynamic> addDocumentRevJo(
      jsonobject.JsonObjectLite<dynamic> document, String revision) {
    document.isImmutable = false;
    document['_rev'] = revision;
    document.isImmutable = false;
    return document;
  }

  /// Adds a CouchDB _id to the json body of a document
  static jsonobject.JsonObjectLite<dynamic> addDocumentIdJo(
      jsonobject.JsonObjectLite<dynamic> document, String id) {
    document.isImmutable = false;
    document['_id'] = id;
    return document;
  }

  /// Adds a CouchDB _deleted to the json body of a document
  static String addDocumentDeleted(
      jsonobject.JsonObjectLite<dynamic> document) {
    document.isImmutable = false;
    document['_deleted'] = true;
    return json.encode(document);
  }

  /// Adds a CouchDB _deleted to the json body of a document
  static jsonobject.JsonObjectLite<dynamic> addDocumentDeleteJo(
      jsonobject.JsonObjectLite<dynamic> document) {
    document.isImmutable = false;
    document['_deleted'] = true;
    document.isImmutable = false;
    return document;
  }

  /// Adds both a CouchDb _id and _rev to the json body of a document
  static jsonobject.JsonObjectLite<dynamic> addDocumentIdRevJojsonobject(
      jsonobject.JsonObjectLite<dynamic> document, String id, String rev) {
    document.isImmutable = false;
    document['_id'] = id;
    document['_rev'] = rev;
    final jsonString = json.encode(document);
    return jsonobject.JsonObjectLite<dynamic>.fromJsonString(jsonString)
      ..isImmutable = false;
  }

  /// Creates a json string for bulk inserts where an
  /// _id and or _rev is needed form document strings
  static String createBulkInsertString(List<String> docStrings) {
    final innerStringBuffer = StringBuffer();
    for (final doc in docStrings) {
      innerStringBuffer.write('$doc,');
    }

    // Remove the last ','
    final len = innerStringBuffer.length;
    final innerString = innerStringBuffer.toString().substring(0, len - 1);
    final insertString = '{"docs":[$innerString]}';
    return insertString.trim();
  }

  /// Creates a json string for bulk inserts where an
  /// _id and or _rev is needed from JsonObjects.
  static String createBulkInsertStringJo(
      List<jsonobject.JsonObjectLite<dynamic>> records) {
    final docStrings = <String>[];
    for (final dynamic record in records) {
      docStrings.add(record.toString());
    }

    return createBulkInsertString(docStrings);
  }

  /// Get a list of attachments from a document.
  ///
  /// Returned Json Object contains the fields 'name' and 'data', the data
  /// being the attachment data returned from CouchDb.
  static List<jsonobject.JsonObjectLite<dynamic>> getAttachments(
      jsonobject.JsonObjectLite<dynamic>? document) {
    final attachmentsList = <jsonobject.JsonObjectLite<dynamic>>[];
    final docString = document.toString();
    final Map<String, dynamic> docMap = json.decode(docString);
    if (docMap.containsKey('_attachments')) {
      final Map<String, dynamic> attachmentList = docMap['_attachments'];
      for (final dynamic key in attachmentList.keys) {
        final dynamic jsonAttachmentData =
            jsonobject.JsonObjectLite<dynamic>.fromJsonString(
                WiltUserUtils.mapToJson(attachmentList[key])!);
        final dynamic jsonAttachment = jsonobject.JsonObjectLite<dynamic>();
        jsonAttachment.name = key;
        jsonAttachment.data = jsonAttachmentData;
        attachmentsList.add(jsonAttachment);
      }
    }

    return attachmentsList;
  }

  /// Serialize a map to a JSON string
  static String? mapToJson(dynamic map) {
    if (map is String) {
      try {
        final dynamic res = json.decode(map);
        if (res != null) {
          return map;
        } else {
          return null;
        }
      } on Exception {
        return null;
      }
    }
    return json.encode(map);
  }

  /// Get a sequence number forom a change notification update, caters
  /// for string based or numerical sequence numbers
  static dynamic getCnSequenceNumber(dynamic seq) => seq;
}
