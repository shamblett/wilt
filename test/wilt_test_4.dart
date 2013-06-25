/*
 * Packge : Wilt
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 04/06/2013
 * Copyright :  S.Hamblett@OSCF
 */

library wilt_test;

import 'dart:async';
import 'dart:json' as json;

import '../lib/wilt.dart';
import 'package:json_object/json_object.dart' as jsonobject;
import 'package:unittest/unittest.dart';  
import 'package:unittest/html_config.dart';
import 'package:unittest/interactive_html_config.dart';
import 'wilt_test_config.dart';

main() {  
  
  useHtmlConfiguration();
  //useInteractiveHtmlConfiguration();
  
  
void myTests(Wilt wilting) {
    
    test("Get Session Information", () {  
    
      void completer(){
      
        jsonobject.JsonObject res = wilting.completionResponse;
        try {
        expect(res.error, isFalse);
        } catch(e) {
        
          logMessage("WILT::Get Session Failed");
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
        expect(successResponse.ok, isTrue);
      
      }
    
      wilting.resultCompletion = completer;
      wilting.getSession();
    
    }); 
  
    test("Get Stats Information", () {  
    
     void completer(){
      
      jsonobject.JsonObject res = wilting.completionResponse;
      try {
      expect(res.error, isFalse);
      } catch(e) {
        
        logMessage("WILT::Get Stats Failed");
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
      expect(successResponse.couchdb, isNotNull);
    }
    
    wilting.resultCompletion = completer;
    wilting.getStats();
     
    
    }); 
  
    test("Get All DB's", () {  
    
      void completer(){
      
        jsonobject.JsonObject res = wilting.completionResponse;
        try {
        expect(res.error, isFalse);
        } catch(e) {
        
          logMessage("WILT::Get All Db's Failed");
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
      expect(successResponse.contains(databaseName), isTrue);
     
      }
    
      wilting.resultCompletion = completer;
      wilting.getAllDbs();
      
    }); 
  
    test("Generate Ids", () {  
    
      void completer(){
      
        jsonobject.JsonObject res = wilting.completionResponse;
        try {
        expect(res.error, isFalse);
        } catch(e) {
        
          logMessage("WILT::Generate Ids");
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
        expect(successResponse.uuids.length, equals(10));
      
      }
    
      wilting.resultCompletion = completer;
      wilting.generateIds(10);
        
    }); 
  }  

  /* Group 5 - Information tests */
  group("Information/Utilty Tests - ", () {
  
    /* Create our Wilt */
    Wilt wilting = new Wilt(hostName, 
        port,
        scheme);
   
   /* Login if we are using authentication */
    if ( userName != null ) {
      
      wilting.login(userName,
                    userPassword);
    }
    
   /* Run the tests */
   myTests(wilting);
   
  });
 
  
}