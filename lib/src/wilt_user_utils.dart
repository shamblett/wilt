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
  /// Get a document id from a JSON Object
  static String getDocumentId(jsonobject.JsonObjectLite response) {
    response.isImmutable = false;
    return response['_id'];
  }

  /// Get a revision from a JSON object
  static String getDocumentRev(jsonobject.JsonObjectLite response) {
    response.isImmutable = false;
    return response['_rev'];
  }

  /// Adds a CouchDB _rev to the JSON body of a document
  static String addDocumentRev(jsonobject.JsonObjectLite document,
      String revision) {
    document.isImmutable = false;
    document["_rev"] = revision;
    return JSON.encode(document);
  }

  /// Adds a CouchDB _id to the JSON body of a document
  static String addDocumentId(jsonobject.JsonObjectLite document, String id) {
    document.isImmutable = false;
    document["_id"] = id;
    return JSON.encode(document);
  }

  /// Adds a CouchDB _rev to the JSON body of a document
  static jsonobject.JsonObjectLite addDocumentRevJo(
      jsonobject.JsonObjectLite document, String revision) {
    document.isImmutable = false;
    document["_rev"] = revision;
    return new jsonobject.JsonObjectLite.fromMap(document)
      ..isImmutable = false;
  }

  /// Adds a CouchDB _id to the JSON body of a document
  static jsonobject.JsonObjectLite addDocumentIdJo(
      jsonobject.JsonObjectLite document, String id) {
    document.isImmutable = false;
    document["_id"] = id;
    return new jsonobject.JsonObjectLite.fromMap(document);
  }

  /// Adds a CouchDB _deleted to the JSON body of a document
  static String addDocumentDeleted(jsonobject.JsonObjectLite document) {
    document.isImmutable = false;
    document["_deleted"] = true;
    return JSON.encode(document);
  }

  /// Adds a CouchDB _deleted to the JSON body of a document
  static jsonobject.JsonObjectLite addDocumentDeleteJo(
      jsonobject.JsonObjectLite document) {
    document.isImmutable = false;
    document["_deleted"] = true;
    return new jsonobject.JsonObjectLite.fromMap(document)
      ..isImmutable = false;
  }

  /// Adds both a CouchDb _id and _rev to the JSON body of a document
  static jsonobject.JsonObjectLite addDocumentIdRevJojsonobject(
      jsonobject.JsonObjectLite document, String id, String rev) {
    document.isImmutable = false;
    document["_id"] = id;
    document['_rev'] = rev;
    final String json = JSON.encode(document);
    return new jsonobject.JsonObjectLite.fromJsonString(json)
      ..isImmutable = false;
  }

  /// Creates a JSON string for bulk inserts where an
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

  /// Creates a JSON string for bulk inserts where an
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
    final Map docMap = JSON.decode(docString);
    if (docMap.containsKey('_attachments')) {
      final Map attachmentList = docMap['_attachments'];
      attachmentList.keys.forEach((key) {
        final jsonobject.JsonObjectLite jsonAttachmentData =
        new jsonobject.JsonObjectLite.fromMap(attachmentList[key]);
        final jsonobject.JsonObjectLite jsonAttachment =
        new jsonobject.JsonObjectLite();
        jsonAttachment.name = key;
        jsonAttachment.data = jsonAttachmentData;
        attachmentsList.add(jsonAttachment);
      });
    }

    return attachmentsList;
  }
}
