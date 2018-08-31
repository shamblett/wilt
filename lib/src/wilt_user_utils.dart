/*
 * Packge : Wilt
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 04/06/2013
 * Copyright :  S.Hamblett@OSCF
 *
 * This class provides Wilt user utility functions 
 */

part of wilt;

class WiltUserUtils {
  /// Get a document id from a json Object
  static String getDocumentId(jsonobject.JsonObjectLite response) {
    response.isImmutable = false;
    return response['_id'];
  }

  /// Get a revision from a json object
  static String getDocumentRev(jsonobject.JsonObjectLite response) {
    response.isImmutable = false;
    return response['_rev'];
  }

  /// Adds a CouchDB _rev to the json body of a document
  static String addDocumentRev(jsonobject.JsonObjectLite document,
      String revision) {
    document.isImmutable = false;
    document["_rev"] = revision;
    return json.encode(document);
  }

  /// Adds a CouchDB _id to the json body of a document
  static String addDocumentId(jsonobject.JsonObjectLite document, String id) {
    document.isImmutable = false;
    document["_id"] = id;
    return json.encode(document);
  }

  /// Adds a CouchDB _rev to the json body of a document
  static jsonobject.JsonObjectLite addDocumentRevJo(
      jsonobject.JsonObjectLite document, String revision) {
    document.isImmutable = false;
    document["_rev"] = revision;
    document.isImmutable = false;
    return document;
  }

  /// Adds a CouchDB _id to the json body of a document
  static jsonobject.JsonObjectLite addDocumentIdJo(
      jsonobject.JsonObjectLite document, String id) {
    document.isImmutable = false;
    document["_id"] = id;
    return document;
  }

  /// Adds a CouchDB _deleted to the json body of a document
  static String addDocumentDeleted(jsonobject.JsonObjectLite document) {
    document.isImmutable = false;
    document["_deleted"] = true;
    return json.encode(document);
  }

  /// Adds a CouchDB _deleted to the json body of a document
  static jsonobject.JsonObjectLite addDocumentDeleteJo(
      jsonobject.JsonObjectLite document) {
    document.isImmutable = false;
    document["_deleted"] = true;
    document.isImmutable = false;
    return document;
  }

  /// Adds both a CouchDb _id and _rev to the json body of a document
  static jsonobject.JsonObjectLite addDocumentIdRevJojsonobject(
      jsonobject.JsonObjectLite document, String id, String rev) {
    document.isImmutable = false;
    document["_id"] = id;
    document['_rev'] = rev;
    final String jsonString = json.encode(document);
    return new jsonobject.JsonObjectLite.fromJsonString(jsonString)
      ..isImmutable = false;
  }

  /// Creates a json string for bulk inserts where an
  /// _id and or _rev is needed form document strings
  static String createBulkInsertString(List<String> docStrings) {
    String innerString = " ";
    for (String doc in docStrings) {
      innerString = "$innerString$doc,";
    }

    /* Remove the last ',' */
    final int len = innerString.length;
    innerString = innerString.substring(0, len - 1);
    final String insertString = '{"docs":[$innerString]}';
    return insertString.trim();
  }

  /// Creates a json string for bulk inserts where an
  /// _id and or _rev is needed from JsonObjects.
  static String createBulkInsertStringJo(
      List<jsonobject.JsonObjectLite> records) {
    final List<String> docStrings = new List<String>();
    records.forEach((record) {
      docStrings.add(record.toString());
    });

    return createBulkInsertString(docStrings);
  }

  /// Get a list of attachments from a document.
  ///
  /// Returned Json Object contains the fields 'name' and 'data', the data
  /// being the attachment data returned from CouchDb.
  static List<jsonobject.JsonObjectLite> getAttachments(
      jsonobject.JsonObjectLite document) {
    final List attachmentsList = new List<jsonobject.JsonObjectLite>();
    final String docString = document.toString();
    final Map docMap = json.decode(docString);
    if (docMap.containsKey('_attachments')) {
      final Map attachmentList = docMap['_attachments'];
      attachmentList.keys.forEach((key) {
        final dynamic jsonAttachmentData =
        new jsonobject.JsonObjectLite.fromJsonString(
            WiltUserUtils.mapToJson(attachmentList[key]));
        final dynamic jsonAttachment = new jsonobject.JsonObjectLite();
        jsonAttachment.name = key;
        jsonAttachment.data = jsonAttachmentData;
        attachmentsList.add(jsonAttachment);
      });
    }

    return attachmentsList;
  }

  /// Serialize a map to a JSON string
  static String mapToJson(dynamic map) {
    if (map is String) {
      try {
        final res = json.decode(map);
        if (res != null) {
          return map;
        } else {
          return null;
        }
      } catch (e) {
        return null;
      }
    }
    return json.encode(map);
  }

  /// Get a sequence number forom a change notification update, caters
  /// for string based or numerical sequence numbers
  static dynamic getCnSequenceNumber(dynamic seq) {
    return seq;
  }
}
