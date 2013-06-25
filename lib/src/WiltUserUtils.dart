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
  
  
  /* Helper utilities for JSON Objct manipulation. CouchDB returns key
   * values with underscores as the first character, e.g. _id, this confuses
   * JSON Objects currently.
   * 
   */
  
  /**
   * Get a document id from a JSON Object
   */
  static String getDocumentId(jsonobject.JsonObject response) {
    
    
    String temp = json.stringify(response);
    Map tempMap = json.parse(temp);
    return tempMap["_id"];
    
  }
  
  /**
   * Get a revision from a JSON object 
   */
  
  static String getDocumentRev(jsonobject.JsonObject response) {
    
    String temp = json.stringify(response);
    Map tempMap = json.parse(temp);
    return tempMap["_rev"];
    
  }
  
  /**
   * Adds a CouchDB _rev to the JSON body of a document
   */
  static String addDocumentRev(jsonobject.JsonObject document,
                        String revision){
    
    String temp = json.stringify(document);
    Map tempMap = json.parse(temp);
    tempMap["_rev"] = revision;
    return json.stringify(tempMap);
    
  }
  
  /**
   * Adds a CouchDB _id to the JSON body of a document
   */
  static String addDocumentId(jsonobject.JsonObject document,
                              String id){
    
    String temp = json.stringify(document);
    Map tempMap = json.parse(temp);
    tempMap["_id"] = id;
    return json.stringify(tempMap);
    
  }
  
  /**
   * Creates a JSON string for bulk inserts where an 
   * _id and or _rev is needed.
   */
  static String createBulkInsertString(List docStrings) {
    
    String innerString = " ";
    for ( String doc in docStrings ) {
      
      innerString = "$innerString$doc,";
    }
    
    /* Remove the last ',' */
    int len = innerString.length;
    innerString = innerString.substring(0, len-1);
    String insertString = '{"docs":[$innerString]}';
    return insertString.trim();
    
  }
  
  
}