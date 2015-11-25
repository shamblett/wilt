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
  /**
   * Get a document id from a JSON Object
   */
  static String getDocumentId(jsonobject.JsonObject response) {
    String temp = JSON.encode(response);
    Map tempMap = JSON.decode(temp);
    return tempMap["_id"];
  }

  /**
   * Get a revision from a JSON object
   */
  static String getDocumentRev(jsonobject.JsonObject response) {
    String temp = JSON.encode(response);
    Map tempMap = JSON.decode(temp);
    return tempMap["_rev"];
  }

  /**
   * Adds a CouchDB _rev to the JSON body of a document
   */
  static String addDocumentRev(jsonobject.JsonObject document,
      String revision) {
    String temp = JSON.encode(document);
    Map tempMap = JSON.decode(temp);
    tempMap["_rev"] = revision;
    return JSON.encode(tempMap);
  }

  /**
   * Adds a CouchDB _id to the JSON body of a document
   */
  static String addDocumentId(jsonobject.JsonObject document, String id) {
    String temp = JSON.encode(document);
    Map tempMap = JSON.decode(temp);
    tempMap["_id"] = id;
    return JSON.encode(tempMap);
  }

  /**
   * Adds a CouchDB _rev to the JSON body of a document
   */
  static jsonobject.JsonObject addDocumentRevJo(jsonobject.JsonObject document,
      String revision) {
    String temp = JSON.encode(document);
    Map tempMap = JSON.decode(temp);
    tempMap["_rev"] = revision;
    return new jsonobject.JsonObject.fromMap(tempMap);
  }

  /**
   * Adds a CouchDB _id to the JSON body of a document
   */
  static jsonobject.JsonObject addDocumentIdJo(jsonobject.JsonObject document,
      String id) {
    String temp = JSON.encode(document);
    Map tempMap = JSON.decode(temp);
    tempMap["_id"] = id;
    return new jsonobject.JsonObject.fromMap(tempMap);
  }

  /**
   * Adds both a CouchDb _id and _rev to the JSON body of a document
   */
  static jsonobject.JsonObject addDocumentIdRevJojsonobject(
      jsonobject.JsonObject document, String id, String rev) {
    String temp = JSON.encode(document);
    Map tempMap = JSON.decode(temp);
    tempMap["_id"] = id;
    tempMap['_rev'] = rev;
    return new jsonobject.JsonObject.fromMap(tempMap);
  }

  /**
   * Creates a JSON string for bulk inserts where an
   * _id and or _rev is needed form document strings
   */
  static String createBulkInsertString(List<String> docStrings) {
    String innerString = " ";
    for (String doc in docStrings) {
      innerString = "$innerString$doc,";
    }

    /* Remove the last ',' */
    int len = innerString.length;
    innerString = innerString.substring(0, len - 1);
    String insertString = '{"docs":[$innerString]}';
    return insertString.trim();
  }

  /**
   * Creates a JSON string for bulk inserts where an
   * _id and or _rev is needed from JsonObjects.
   */
  static String createBulkInsertStringJo(List<jsonobject.JsonObject> records) {
    List<String> docStrings = new List<String>();
    records.forEach((record) {
      docStrings.add(record.toString());
    });

    return createBulkInsertString(docStrings);

  }

  /**
   * Get a list of attachments from a document.
   *
   * Returned Json Object contains the fields 'name' and 'data', the data
   * being the attachment data returned from CouchDb.
   *
   */
  static List<jsonobject.JsonObject> getAttachments(
      jsonobject.JsonObject document) {
    List attachmentsList = new List<jsonobject.JsonObject>();
    String docString = document.toString();
    Map docMap = JSON.decode(docString);
    if (docMap.containsKey('_attachments')) {
      Map attachmentList = docMap['_attachments'];
      attachmentList.keys.forEach((key) {
        jsonobject.JsonObject jsonAttachmentData =
            new jsonobject.JsonObject.fromMap(attachmentList[key]);
        jsonobject.JsonObject jsonAttachment = new jsonobject.JsonObject();
        jsonAttachment.name = key;
        jsonAttachment.data = jsonAttachmentData;
        attachmentsList.add(jsonAttachment);
      });
    }

    return attachmentsList;
  }
}
