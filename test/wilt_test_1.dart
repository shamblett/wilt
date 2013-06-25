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
  
  
  /* Tests */
  
  /* Group 1 - Wilt constructor tests */
  group("1. Constructor Tests - ", () {
    
    test("No hostname", () {  
      
      void wrapper(){
        
        Wilt wilting = new Wilt(null, 
                                port,
                                scheme); 
       
      }
      
      expect(wrapper,throwsA(new isInstanceOf<WiltException>()));
      
      
    }); 
    
    test("No port", () {  
      
      void wrapper(){
        
        Wilt wilting = new Wilt(hostName, 
                                null,
                                scheme); 
       
      }
      
      expect(wrapper,throwsA(new isInstanceOf<WiltException>()));
      
      
    }); 
    
    test("No Scheme", () {  
      
      void wrapper(){
        
        Wilt wilting = new Wilt(hostName, 
                                port,
                                null); 
       
      }
      
      expect(wrapper,throwsA(new isInstanceOf<WiltException>()));
      
      
    }); 
    
  });
  
  /* Group 2 - Basic methods parameter validation  */
  group("2. Basic Methods Parameter Validation - ", () {
    
    
    test("No Database Set HEAD", () {  
      
      Wilt wilting = new Wilt(hostName, 
          port,
          scheme);
      
      void wrapper(){
        wilting.head(null);
      }
      
      expect(wrapper,throwsA(new isInstanceOf<WiltException>()));
      
      
    }); 
    
    test("No Database Set GET", () {  
      
      Wilt wilting = new Wilt(hostName, 
          port,
          scheme);
      
      void wrapper(){
        wilting.get(null);
      }
      
      expect(wrapper,throwsA(new isInstanceOf<WiltException>()));
      
      
    }); 
    
    test("No Database Set POST", () {  
      
      Wilt wilting = new Wilt(hostName, 
          port,
          scheme);
      
      void wrapper(){
        wilting.post(null, null);
      }
      
      expect(wrapper,throwsA(new isInstanceOf<WiltException>()));
      
      
    }); 
    
    test("No Database Set PUT", () {  
      
      Wilt wilting = new Wilt(hostName, 
          port,
          scheme);
      
      void wrapper(){
        wilting.put(null, "1");
      }
      
      expect(wrapper,throwsA(new isInstanceOf<WiltException>()));
      
      
    });
  
    test("No Database Set DELETE", () {  
    
    Wilt wilting = new Wilt(hostName, 
        port,
        scheme);
    
    void wrapper(){
      wilting.delete(null);
    }
    
    expect(wrapper,throwsA(new isInstanceOf<WiltException>()));
    
    
  }); 
  
  });
  
  /* Group 3 - Document/Database methods parameter validation  */
  group("3. Document/Database Parameter Validation - ", () {
    
   
    test("Get Document no id", () {  
      
      Wilt wilting = new Wilt(hostName, 
          port,
          scheme);
      
      void wrapper(){
        wilting.getDocument(null);
      }
      
      expect(wrapper,throwsA(new isInstanceOf<WiltException>()));
      
      
    }); 
    
  
    test("Delete Document no id", () {  
    
      Wilt wilting = new Wilt(hostName, 
        port,
        scheme);
    
      void wrapper(){
        wilting.deleteDocument(null, null);
    }
    
    expect(wrapper,throwsA(new isInstanceOf<WiltException>()));
    
    
    }); 
  
    test("Delete Document no rev", () {  
    
      Wilt wilting = new Wilt(hostName, 
        port,
        scheme);
    
     void wrapper(){
      wilting.deleteDocument("1", null);
    }
    
    expect(wrapper,throwsA(new isInstanceOf<WiltException>()));
    
    });
  
    test("Put Document no id", () {  
      
      Wilt wilting = new Wilt(hostName, 
          port,
          scheme);
      
      void wrapper(){
        jsonobject.JsonObject doc;
        wilting.putDocument(null, doc);
      }
      
      expect(wrapper,throwsA(new isInstanceOf<WiltException>()));
      
      
    }); 
    
    test("Put Document no data", () {  
      
      Wilt wilting = new Wilt(hostName, 
          port,
          scheme);
      
      void wrapper(){
        wilting.putDocument("1", null);
      }
      
      expect(wrapper,throwsA(new isInstanceOf<WiltException>()));
      
    
    }); 
    
    test("Post Document no document body", () {  
      
      Wilt wilting = new Wilt(hostName, 
          port,
          scheme);
      
      void wrapper(){
        jsonobject.JsonObject doc;
        wilting.postDocument(null);
      }
      
      expect(wrapper,throwsA(new isInstanceOf<WiltException>()));
      
      
    }); 
    
    test("Post Document String no document string", () {  
      
      Wilt wilting = new Wilt(hostName, 
          port,
          scheme);
      
      void wrapper(){
        jsonobject.JsonObject doc;
        wilting.postDocumentString(null);
      }
      
      expect(wrapper,throwsA(new isInstanceOf<WiltException>()));
      
      
    }); 
  
    test("Create Database no name", () {  
    
      Wilt wilting = new Wilt(hostName, 
        port,
        scheme);
    
      void wrapper(){
        wilting.createDatabase(null);
      }
    
    expect(wrapper,throwsA(new isInstanceOf<WiltException>()));
    
    
   }); 
  
   test("Delete Database no name", () {  
    
    Wilt wilting = new Wilt(hostName, 
        port,
        scheme);
    
    void wrapper(){
      wilting.deleteDatabase(null);
    }
    
    expect(wrapper,throwsA(new isInstanceOf<WiltException>()));
    
    
  }); 
   
    test("All Docs invalid limit ", () {  
     
     Wilt wilting = new Wilt(hostName, 
         port,
         scheme);
     
     void wrapper(){
       wilting.getAllDocs(limit:-1);
     }
     
     expect(wrapper,throwsA(new isInstanceOf<WiltException>()));
     
     
   }); 
   
    test("Generate Ids invalid amount ", () {  
     
     Wilt wilting = new Wilt(hostName, 
         port,
         scheme);
     
     void wrapper(){
       wilting.generateIds(-1);
     }
     
     expect(wrapper,throwsA(new isInstanceOf<WiltException>()));
     
     
   }); 
    
    test("Copy document no source id", () {  
      
      Wilt wilting = new Wilt(hostName, 
          port,
          scheme);
      
      void wrapper(){
        wilting.copyDocument(null,'1');;
      }
      
      expect(wrapper,throwsA(new isInstanceOf<WiltException>()));
      
      
    });  
    
    test("Copy document no destinationid", () {  
      
      Wilt wilting = new Wilt(hostName, 
          port,
          scheme);
      
      void wrapper(){
        wilting.copyDocument('1', null);;
      }
      
      expect(wrapper,throwsA(new isInstanceOf<WiltException>()));
      
      
    });  
    
    test("Login null user name", () {  
      
      Wilt wilting = new Wilt(hostName, 
          port,
          scheme);
      
      void wrapper(){
        wilting.login(null,
                      "password");
      }
      
      expect(wrapper,throwsA(new isInstanceOf<WiltException>()));
      
      
    }); 
    
    test("Login null password", () {  
      
      Wilt wilting = new Wilt(hostName, 
          port,
          scheme);
      
      void wrapper(){
        wilting.login("name",
                       null);
      }
      
      expect(wrapper,throwsA(new isInstanceOf<WiltException>()));
      
      
    }); 
    
  });
  
}