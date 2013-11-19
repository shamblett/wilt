/*
 * Packge : Wilt
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 04/06/2013
 * Copyright :  S.Hamblett@OSCF
 */

library wilt_test;

import '../lib/wilt.dart';
import 'package:json_object/json_object.dart' as jsonobject;
import 'package:unittest/unittest.dart';  
import 'package:unittest/html_config.dart';
import 'wilt_test_config.dart';

main() {  
  
  useHtmlConfiguration();
  
  /* Group 5 - Bulk documents */
  group("5. Bulk Documents - ", () {
    
    
    /* Create our Wilt */
    Wilt wilting = new Wilt(hostName, 
        port,
        scheme);
   
   /* Login if we are using authentication */
    if ( userName != null ) {
      
      wilting.login(userName,
                    userPassword);
    }
    
    /* Setup */
    String docId = null;
    String docRev = null;
    String putId = 'mytestid';
    String putId2 = 'mytestid2';
    String putId3 = 'mytestid3';
    String copyId = 'mycopyid';
    
    test("Get All Docs  - Include docs", () {  
      
      Wilt wilting = new Wilt(hostName, 
          port,
          scheme);
      
      
      var completer = expectAsync0((){
        
        jsonobject.JsonObject res = wilting.completionResponse;
        try {
          expect(res.error, isFalse);
        } catch(e) {
          
          logMessage("WILT::Get All Docs  - Include docs");
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }
        
        jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        expect(successResponse.total_rows, equals(4));
        expect(successResponse.rows[1].id, equals(copyId));
        expect(successResponse.rows[2].id, equals(putId));
        
      });
      
      wilting.resultCompletion = completer;
      wilting.db = databaseName;
      wilting.getAllDocs(includeDocs:true);
      
      
    }); 
    
    test("Get All Docs  - limit", () {  
      
      Wilt wilting = new Wilt(hostName, 
          port,
          scheme);
      
      
      var completer = expectAsync0((){
        
        jsonobject.JsonObject res = wilting.completionResponse;
        try {
          expect(res.error, isFalse);
        } catch(e) {
          
          logMessage("WILT::Get All Docs  - limit");
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }
        
        jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        expect(successResponse.total_rows, equals(4));
        expect(successResponse.rows[0].id, isNot(equals(putId)));
        expect(successResponse.rows[0].id, isNot(equals(putId2)));
        int count = 0;
        for (final x in successResponse.rows ) {
          
          count++;
        }
        expect(count, equals(1));
        
      });
      
      wilting.resultCompletion = completer;
      wilting.db = databaseName;
      wilting.getAllDocs(limit:1);
      
      
    }); 
    
  
     test("Get All Docs  - start key", () {  
      
      Wilt wilting = new Wilt(hostName, 
          port,
          scheme);
      
      
      var completer = expectAsync0((){
        
        jsonobject.JsonObject res = wilting.completionResponse;
        try {
          expect(res.error, isFalse);
        } catch(e) {
          
          logMessage("WILT::Get All Docs  - start key");
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }
        
        jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        expect(successResponse.total_rows, equals(4));
        expect(successResponse.rows[0].id, equals(putId));
        expect(successResponse.rows[1].id, equals(putId2));
        int count = 0;
        for (final x in successResponse.rows ) {
          
          count++;
        }
        expect(count, equals(2));
        
      });
      
      wilting.resultCompletion = completer;
      wilting.db = databaseName;
      wilting.getAllDocs(startKey:putId);
      
      
    }); 
    
    test("Get All Docs  - end key", () {  
      
      Wilt wilting = new Wilt(hostName, 
          port,
          scheme);
      
      
      var completer = expectAsync0((){
        
        jsonobject.JsonObject res = wilting.completionResponse;
        try {
          expect(res.error, isFalse);
        } catch(e) {
          
          logMessage("WILT::Test Get All Docs  - end key");
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }
        
        jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        expect(successResponse.total_rows, equals(4));
        expect(successResponse.rows[1].id, equals(copyId));
        expect(successResponse.rows[2].id, equals(putId));
        int count = 0;
        for (final x in successResponse.rows ) {
          
          count++;
        }
        expect(count, equals(4));
        
      });
      
      wilting.resultCompletion = completer;
      wilting.db = databaseName;
      wilting.getAllDocs(endKey:putId2);
      
      
    }); 
    
    test("Get All Docs - key list", () {  
      
      Wilt wilting = new Wilt(hostName, 
          port,
          scheme);
      
      
      var completer = expectAsync0((){
        
        jsonobject.JsonObject res = wilting.completionResponse;
        try {
          expect(res.error, isFalse);
        } catch(e) {
          
          logMessage("WILT::Test Get All Docs  - key list");
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }
        
        jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        expect(successResponse.total_rows, equals(4));
        expect(successResponse.rows[0].id, equals(putId));
        expect(successResponse.rows[1].id, equals(putId2));
        int count = 0;
        for (final x in successResponse.rows ) {
          
          count++;
        }
        expect(count, equals(2));
        
      });
      
      wilting.resultCompletion = completer;
      wilting.db = databaseName;
      List keyList = new List<String>();
      keyList.add(putId);
      keyList.add(putId2);
      wilting.getAllDocs(keys:keyList);
      
      
    }); 
    
     test("Get All Docs  - descending", () {  
      
      Wilt wilting = new Wilt(hostName, 
          port,
          scheme);
      
      
      var completer = expectAsync0((){
        
        jsonobject.JsonObject res = wilting.completionResponse;
        try {
          expect(res.error, isFalse);
        } catch(e) {
        
          logMessage("WILT::Get All Docs  - descending");
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }
        
        jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        expect(successResponse.total_rows, equals(4));
        expect(successResponse.rows[1].id, equals(putId));
        expect(successResponse.rows[0].id, equals(putId2));
        int count = 0;
        for (final x in successResponse.rows ) {
          
          count++;
        }
        expect(count, equals(2));
        
      });
      
      wilting.resultCompletion = completer;
      wilting.db = databaseName;
      List keyList = new List<String>();
      keyList.add(putId);
      keyList.add(putId2);
      wilting.getAllDocs(keys:keyList,
                         descending:true);
      
      
    }); 
     
     test("Bulk Insert Auto Keys", () {  
       
       Wilt wilting = new Wilt(hostName, 
           port,
           scheme);
       
       
       var completer = expectAsync0((){
         
         jsonobject.JsonObject res = wilting.completionResponse;
         try {
           expect(res.error, isFalse);
         } catch(e) {
           
           logMessage("WILT::Bulk Insert Auto Keys");
           jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
           String errorText = errorResponse.error;
           logMessage("WILT::Error is $errorText");
           String reasonText = errorResponse.reason;
           logMessage("WILT::Reason is $reasonText");
           int statusCode = res.errorCode;
           logMessage("WILT::Status code is $statusCode");
           return;
         }
         
         jsonobject.JsonObject successResponse = res.jsonCouchResponse;
         expect(successResponse[0].ok, isTrue);
         expect(successResponse[1].ok, isTrue);
         expect(successResponse[2].ok, isTrue);
         
       });
       
       wilting.resultCompletion = completer;
       wilting.db = databaseName;
       List docList = new List<jsonobject.JsonObject>();
       jsonobject.JsonObject document1 = new jsonobject.JsonObject();
       document1.title = "Document 1";
       document1.version = 1;
       document1.attribute = "Doc 1 attribute";
       docList.add(document1);
       jsonobject.JsonObject document2 = new jsonobject.JsonObject();
       document2.title = "Document 2";
       document2.version = 2;
       document2.attribute = "Doc 2 attribute";
       docList.add(document2);
       jsonobject.JsonObject document3 = new jsonobject.JsonObject();
       document3.title = "Document 3";
       document3.version = 3;
       document3.attribute = "Doc 3 attribute";
       docList.add(document3);
       
       wilting.bulk(docList);    
       
     }); 
    
      test("Bulk Insert Supplied Keys", () {  
       
       Wilt wilting = new Wilt(hostName, 
           port,
           scheme);
       
       
       var completer = expectAsync0((){
         
         jsonobject.JsonObject res = wilting.completionResponse;
         try {
           expect(res.error, isFalse);
         } catch(e) {
           
           logMessage("WILT::Bulk Insert Supplied Keys");
           jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
           String errorText = errorResponse.error;
           logMessage("WILT::Error is $errorText");
           String reasonText = errorResponse.reason;
           logMessage("WILT::Reason is $reasonText");
           int statusCode = res.errorCode;
           logMessage("WILT::Status code is $statusCode");
           return;
         }
         
         jsonobject.JsonObject successResponse = res.jsonCouchResponse;
         expect(successResponse[0].id, equals("MyBulkId1"));
         expect(successResponse[1].id, equals("MyBulkId2")); 
         expect(successResponse[2].id, equals("MyBulkId3"));
         
       });
       
       wilting.resultCompletion = completer;
       wilting.db = databaseName;
      
       jsonobject.JsonObject document1 = new jsonobject.JsonObject();
       document1.title = "Document 1";
       document1.version = 1;
       document1.attribute = "Doc 1 attribute";
       String doc1 = WiltUserUtils.addDocumentId(document1, 
                                                 "MyBulkId1");
       jsonobject.JsonObject document2 = new jsonobject.JsonObject();
       document2.title = "Document 2";
       document2.version = 2;
       document2.attribute = "Doc 2 attribute";
       String doc2 = WiltUserUtils.addDocumentId(document2,
                                                 "MyBulkId2");
       jsonobject.JsonObject document3 = new jsonobject.JsonObject();
       document3.title = "Document 3";
       document3.version = 3;
       document3.attribute = "Doc 3 attribute";
       String doc3 = WiltUserUtils.addDocumentId(document3,
                                                 "MyBulkId3");       
       List docList = new List<String>();
       docList.add(doc1);
       docList.add(doc2);
       docList.add(doc3);
       String docs = WiltUserUtils.createBulkInsertString(docList);
       wilting.bulkString(docs);    
       
     });  
   
  });
    
}
