/*
 * Packge : Wilt
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 04/06/2013
 * Copyright :  S.Hamblett@OSCF
 */

library wilt_test;

import 'dart:async';
import '../lib/wilt.dart';
import 'package:json_object/json_object.dart' as jsonobject;
import 'package:unittest/unittest.dart';  
import 'package:unittest/html_config.dart';
import 'wilt_test_config.dart';

main() {  
  
  useHtmlConfiguration();
  
  /* Group 4 - Single documents and database methods */
  group("4. Single documents and database - ", () {
  
    
    /* Create our Wilt */
    Wilt wilting = new Wilt(hostName, 
        port,
        scheme);
   

   /* Login if we are using authentication */
    if ( userName != null ) {
      
      wilting.login(userName,
                    userPassword);
    }
    
    /*Group setup */   
    String docId = null;
    String docRev = null;
    String putId = 'myuniqueid';
    String putId2 = 'myuniqueid2';
    String putId3 = 'myuniqueid3';
    String copyId = 'mycopyid';
    
    /* Duration for callback test */
    Duration testDuration = new Duration(milliseconds:TEST_DURATION);
    
    skip_test("Create Database not authorized", () {  
      
      /* Create a local wilting for this test */
      Wilt localWilting = new Wilt(hostName, 
          port,
          scheme);
        
      localWilting.login('freddy',
                         'freddypass');
 
      void completer(){
        
        jsonobject.JsonObject res = localWilting.completionResponse;
        try {
          expect(res.error, isFalse);
        } catch(e) {
        
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          expect(errorResponse.error, equals('unauthorized'));
          expect(errorResponse.reason, equals('Name or password is incorrect.'));
          expect(res.errorCode, equals(401));
          return;
        }
        
      }
      
      localWilting.resultCompletion = completer;
      localWilting.createDatabase(databaseName);
      
    });
    
    /* Create the test database */
    test("Create Test Database", () {  
      
      Future done = new Future.delayed(testDuration,
                                       () => true);
      
      void completer(){
        
        jsonobject.JsonObject res = wilting.completionResponse;
        try {
          expect(res.error, isFalse);
        } catch(e) {
          
          logMessage("WILT::Create Test Database Failed");
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          throw new WiltException('WILT::Create Test Database Failed');
        }
        
        jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        expect(successResponse.ok, isTrue);
        
      }
    
      wilting.resultCompletion = completer;
      wilting.createDatabase(databaseName);
      return done;
      
    });
    
    /* Create a database then delete it */ 
    test("Delete Database", () {  
      
      Future done = new Future.delayed(testDuration,
          () => true);
      
      void checkCompleter(){
       
       jsonobject.JsonObject res = wilting.completionResponse;
       try {
         expect(res.error, isFalse);
       } catch(e) {
         
         logMessage("WILT::Delete Database check");
         jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
         String errorText = errorResponse.error;
         logMessage("WILT::Error is $errorText");
         String reasonText = errorResponse.reason;
         logMessage("WILT::Reason is $reasonText");
         int statusCode = res.errorCode;
         logMessage("WILT::Status code is $statusCode");
         throw new WiltException('WILT::Delete Database Failed Check.');
       }
       
     }
      
     void completer(){
       
       jsonobject.JsonObject res = wilting.completionResponse;
       try {
         expect(res.error, isFalse);
       } catch(e) {
         
         logMessage("WILT::Create Database Failed");
         jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
         String errorText = errorResponse.error;
         logMessage("WILT::Error is $errorText");
         String reasonText = errorResponse.reason;
         logMessage("WILT::Reason is $reasonText");
         int statusCode = res.errorCode;
         logMessage("WILT::Status code is $statusCode");
         throw new WiltException('WILT::Delete Database Failed.');
       }
       
       /* Now delete it */
       wilting.resultCompletion = checkCompleter;
       wilting.deleteDatabase("wiltdeleteme");
       
       
     }
     
     wilting.resultCompletion = completer;
     wilting.createDatabase("wiltdeleteme");
     return done;
         
   });
  
  
  test("HEAD null URL", () { 
    
    Future done = new Future.delayed(testDuration,
        () => true);
    
    void completer(){
      
      jsonobject.JsonObject res = wilting.completionResponse;
      try {
      expect(res.error, isFalse);
      } catch(e) {
        
        logMessage("WILT::Head null URL");
        jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
        String errorText = errorResponse.error;
        logMessage("WILT::Error is $errorText");
        String reasonText = errorResponse.reason;
        logMessage("WILT::Reason is $reasonText");
        int statusCode = res.errorCode;
        logMessage("WILT::Status code is $statusCode");
        throw new WiltException('WILT::HEAD null URL Failed.');
      }
      
    }
    
    wilting.resultCompletion = completer;
    wilting.db = databaseName;
    wilting.head(null);
    return done;
     
    
  }); 
  
   test("Create document(POST) and check", () {  
        
     Future done = new Future.delayed(testDuration,
         () => true);
     
    void checkCompleter(){
      
      jsonobject.JsonObject res = wilting.completionResponse;
      try {
        expect(res.error, isFalse);
      } catch(e) {
        
        logMessage("WILT::Create Document(POST) and check creation");
        jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
        String errorText = errorResponse.error;
        logMessage("WILT::Error is $errorText");
        String reasonText = errorResponse.reason;
        logMessage("WILT::Reason is $reasonText");
        int statusCode = res.errorCode;
        logMessage("WILT::Status code is $statusCode");
        throw new WiltException('WILT::Create document(POST) Check Failed');
      }
      
      /* Check the documents parameters */
      jsonobject.JsonObject successResponse = res.jsonCouchResponse;
      String returnedDocId = WiltUserUtils.getDocumentId(successResponse);
      expect(returnedDocId, docId);
      String returnedDocRev = WiltUserUtils.getDocumentRev(successResponse);
      expect(successResponse.title, equals("Created by a Post Request"));
      expect(successResponse.version, equals(1));
      expect(successResponse.author, equals("Me"));
    }
    
    void completer(){
      
      jsonobject.JsonObject res = wilting.completionResponse;
      try {
      expect(res.error, isFalse);
      } catch(e) {
        
        logMessage("WILT::Create Document(POST) and check");
        jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
        String errorText = errorResponse.error;
        logMessage("WILT::Error is $errorText");
        String reasonText = errorResponse.reason;
        logMessage("WILT::Reason is $reasonText");
        int statusCode = res.errorCode;
        logMessage("WILT::Status code is $statusCode");
        String responseHeaders = wilting.responseHeaders;
        logMessage("WILT::Response headers are $responseHeaders");
        throw new WiltException('WILT::Create document(POST) Failed');
      }
      
      /* Get the documents id and re-get the document to check correctness */
      jsonobject.JsonObject successResponse = res.jsonCouchResponse;
      docId = successResponse.id;
      expect(docId, isNot(isEmpty));
      /* Now get the document and check it */
      wilting.resultCompletion = checkCompleter;
      wilting.getDocument(docId);
     
    }
    
    wilting.resultCompletion = completer;
    wilting.db = databaseName;
    jsonobject.JsonObject document = new jsonobject.JsonObject();
    document.title = "Created by a Post Request";
    document.version = 1;
    document.author = "Me";
    wilting.postDocument(document);
    return done;
    
  }); 
   
   test("Create document(PUT) and check", () {  
     
     
     Future done = new Future.delayed(testDuration,
         () => true);
     
     void checkCompleter(){
       
       jsonobject.JsonObject res = wilting.completionResponse;
       try {
         expect(res.error, isFalse);
       } catch(e) {
         
         logMessage("WILT::Create Document(PUT) and check updated");
         jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
         String errorText = errorResponse.error;
         logMessage("WILT::Error is $errorText");
         String reasonText = errorResponse.reason;
         logMessage("WILT::Reason is $reasonText");
         int statusCode = res.errorCode;
         logMessage("WILT::Status code is $statusCode");
         throw new WiltException('WILT::Create document(PUT) Check Failed');
       }
       
       /* Check the documents parameters */
       jsonobject.JsonObject successResponse = res.jsonCouchResponse;
       String returnedDocId = WiltUserUtils.getDocumentId(successResponse);
       expect(returnedDocId, putId);
       String returnedDocRev = WiltUserUtils.getDocumentRev(successResponse);
       expect(successResponse.title, equals("Created by a Put Request"));
       expect(successResponse.version, equals(2));
       expect(successResponse.author, equals("Me again"));
       
     }
     
     void completer(){
       
       jsonobject.JsonObject res = wilting.completionResponse;
       try {
         expect(res.error, isFalse);
       } catch(e) {
         
         logMessage("WILT::Test Put Document and check");
         jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
         String errorText = errorResponse.error;
         logMessage("WILT::Error is $errorText");
         String reasonText = errorResponse.reason;
         logMessage("WILT::Reason is $reasonText");
         int statusCode = res.errorCode;
         logMessage("WILT::Status code is $statusCode");
         throw new WiltException('WILT::Create document(PUT) Failed');
       }
       
       /* Get the documents id and re-get the document to check correctness */
       jsonobject.JsonObject successResponse = res.jsonCouchResponse;
       String putDocId = successResponse.id;
       expect(putDocId, equals(putId));
       /* Now get the document and check it */
       wilting.resultCompletion = checkCompleter;
       wilting.getDocument(putId);
       
     }
     
     wilting.resultCompletion = completer;
     wilting.db = databaseName;
     jsonobject.JsonObject document = new jsonobject.JsonObject();
     document.title = "Created by a Put Request";
     document.version = 2;
     document.author = "Me again";
     wilting.putDocument(putId,
                         document);   
     return done;
     
   }); 
   
    test("Update document and check", () {  
     
      Future done = new Future.delayed(testDuration,
          () => true);
      
    void checkUpdater(){
       
       jsonobject.JsonObject res = wilting.completionResponse;
       try {
         expect(res.error, isFalse);
       } catch(e) {
         
         logMessage("WILT::Update document and check updated");
         jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
         String errorText = errorResponse.error;
         logMessage("WILT::Error is $errorText");
         String reasonText = errorResponse.reason;
         logMessage("WILT::Reason is $reasonText");
         int statusCode = res.errorCode;
         logMessage("WILT::Status code is $statusCode");
         throw new WiltException('WILT::Update Document Check 3 Failed');
       }
       
       /* Check the documents parameters */
       jsonobject.JsonObject successResponse = res.jsonCouchResponse;
       String returnedDocId = successResponse.id;
       expect(returnedDocId, equals(putId2));
       String returnedDocRev = successResponse.rev;    
       expect(returnedDocRev, isNot(equals(docRev)));
       
     }
    
     void checkCompleter(){
       
       jsonobject.JsonObject res = wilting.completionResponse;
       try {
         expect(res.error, isFalse);
       } catch(e) {
         
         logMessage("WILT::Update document and check created");
         jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
         String errorText = errorResponse.error;
         logMessage("WILT::Error is $errorText");
         String reasonText = errorResponse.reason;
         logMessage("WILT::Reason is $reasonText");
         int statusCode = res.errorCode;
         logMessage("WILT::Status code is $statusCode");
         throw new WiltException('WILT::Update Document Check 2 Failed');
       }
       
       /* Check the documents parameters */
       jsonobject.JsonObject successResponse = res.jsonCouchResponse;
       String returnedDocId = WiltUserUtils.getDocumentId(successResponse);
       expect(returnedDocId, putId2);
       String returnedDocRev = WiltUserUtils.getDocumentRev(successResponse);
       docRev = returnedDocRev;
       expect(successResponse.title, equals("Created by a Put Request for checking"));
       expect(successResponse.version, equals(3));
       expect(successResponse.author, equals( "Me also"));
       /* Now alter the document using putDocument */
       jsonobject.JsonObject document = new jsonobject.JsonObject();
       document.title = "Created by a Put Request for updating ";
       document.version = 4;
       document.author = "Me also and again";
       String docString = WiltUserUtils.addDocumentRev(document,
                                                       returnedDocRev);
       wilting.resultCompletion = checkUpdater;
       wilting.putDocumentString(putId2,
                                 docString);
      
     }
     
     void completer(){
       
       jsonobject.JsonObject res = wilting.completionResponse;
       try {
         expect(res.error, isFalse);
       } catch(e) {
         
         logMessage("WILT::Update document and check");
         jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
         String errorText = errorResponse.error;
         logMessage("WILT::Error is $errorText");
         String reasonText = errorResponse.reason;
         logMessage("WILT::Reason is $reasonText");
         int statusCode = res.errorCode;
         logMessage("WILT::Status code is $statusCode");
         throw new WiltException('WILT::Update Document Check 1 Failed');
       }
       
       /* Get the documents id and re-get the document to check correctness */
       jsonobject.JsonObject successResponse = res.jsonCouchResponse;
       String putDocId = successResponse.id;
       expect(putDocId, equals(putId2));
       /* Now get the document and check it */
       wilting.resultCompletion = checkCompleter;
       wilting.getDocument(putId2);
     
     }
     
     wilting.resultCompletion = completer;
     wilting.db = databaseName;
     jsonobject.JsonObject document = new jsonobject.JsonObject();
     document.title = "Created by a Put Request for checking";
     document.version = 3;
     document.author = "Me also";
     wilting.putDocument(putId2,
                         document); 
     return done;
     
   }); 
   
    test("Delete document and check ", () {  
      
      Future done = new Future.delayed(testDuration,
          () => true);
      
      void checkCompleter(){
        
        jsonobject.JsonObject res = wilting.completionResponse;
        try {
          expect(res.error, isFalse);
        } catch(e) {
          
          logMessage("WILT::Delete document and check deletion");
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          throw new WiltException('WILT::Delete document Check 1 Failed');
        }
        
        /* Check the document has been deleted */
        jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        String putDocId = successResponse.id;
        expect(putDocId, equals(putId3));
      }
      
      void completer(){
        
        jsonobject.JsonObject res = wilting.completionResponse;
        try {
          expect(res.error, isFalse);
        } catch(e) {
          
          logMessage("WILT::Delete document and check");
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          throw new WiltException('WILT::Delete document Check 2 Failed');
        }
        
        /* Get the documents id and re-get the document to check correctness */
        jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        String putDocId = successResponse.id;
        expect(putDocId, equals(putId3));
        String returnedDocRev = successResponse.rev;  
        /* Now delete the document and check it */
        wilting.resultCompletion = checkCompleter;
        wilting.deleteDocument(putId3,
                               returnedDocRev);
        
      }
      
      wilting.resultCompletion = completer;
      wilting.db = databaseName;
      jsonobject.JsonObject document = new jsonobject.JsonObject();
      document.title = "Created by a Put Request for deleting";
      document.version = 1;
      document.author = "Its me again";
      wilting.putDocument(putId3,
                          document);
      return done;
      
    }); 
    
    test("Copy document and check ", () {  
      
      Future done = new Future.delayed(testDuration,
          () => true);
      
      void checkCompleter(){
        
        jsonobject.JsonObject res = wilting.completionResponse;
        try {
          expect(res.error, isFalse);
        } catch(e) {
          
          logMessage("WILT::Copy document and check copy");
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          throw new WiltException('WILT::Copy Document Check 1 Failed');
        }
        
        /* Check the document has been retrieved*/
        jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        String returnedDocId = WiltUserUtils.getDocumentId(successResponse);
        expect(returnedDocId, equals(copyId));
      }
      
      void completer(){
        
        jsonobject.JsonObject res = wilting.completionResponse;
        try {
          expect(res.error, isFalse);
        } catch(e) {
          
          logMessage("WILT::Copy document and check");
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          throw new WiltException('WILT::Copy Document Check Failed');
        }
        
        /* Get the copied document */
        jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        String copyDocId = successResponse.id;
        expect(copyDocId, equals(copyDocId));
        wilting.resultCompletion = checkCompleter;
        wilting.getDocument(copyId);
      }
      
      wilting.resultCompletion = completer;
      wilting.db = databaseName;
      wilting.copyDocument(putId,
                           copyId);
      return done;
      
    }); 
   
    /* Raw HTTP Request */
    test("Raw HTTP Request", () {  
      
      Future done = new Future.delayed(testDuration,
          () => true);
      
      void completer(){
        
        jsonobject.JsonObject res = wilting.completionResponse;
        try {
          expect(res.error, isFalse);
        } catch(e) {
          
          logMessage("WILT::Raw HTTP Request failed");
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          throw new WiltException('WILT::Raw HTTP Request Failed');
        }
        
        jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        String returnedDocId = WiltUserUtils.getDocumentId(successResponse);
        expect(returnedDocId, putId);
        
      }
      
      wilting.resultCompletion = completer;
      String url = "/$databaseName/$putId";
      wilting.httpRequest(url);
      return done;
      
    });
    
  });
  
}