/*
 * Package : WiltBrowserClient
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 04/06/2013
 * Copyright :  S.Hamblett@OSCF
 */

library wilt_test_browser_completion;

import 'dart:html';

import 'package:wilt/wilt.dart';
import 'package:wilt/wilt_browser_client.dart';
import 'package:json_object/json_object.dart' as jsonobject;
import 'package:unittest/unittest.dart';
import 'package:unittest/html_config.dart';
import 'wilt_test_config.dart';

main() {

  useHtmlConfiguration();


  /* Tests */

  /* Group 1 - WiltBrowserClient constructor tests */
  group("1. Constructor Tests - ", () {

    test("No hostname", () {

      try {
        WiltBrowserClient wilting = new WiltBrowserClient(null, port, scheme);
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = Bad construction - some or all required parameters are null'
            );

      }



    });

    test("No port", () {

      try {
        WiltBrowserClient wilting = new WiltBrowserClient(hostName, null, scheme
            );
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = Bad construction - some or all required parameters are null'
            );
      }


    });

    test("No Scheme", () {

      try {
        WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, null);
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = Bad construction - some or all required parameters are null'
            );
      }

    });

    test("No HTTP Adapter", () {

      try {
        WiltBrowserClient wilting = new WiltBrowserClient(hostName, port,
            scheme, null);
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = Bad construction - you must instantiate Wilt with a HTTP Adapter'
            );
      }

    });


  });

  /* Group 2 - Basic methods parameter validation  */
  group("2. Basic Methods Parameter Validation - ", () {


    test("No Database Set HEAD", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {
        wilting.head(null);

      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(), 'WiltException: message = No database specified');
      }

    });

    test("No Database Set GET", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {
        wilting.get(null);
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(), 'WiltException: message = No database specified');
      }


    });

    test("No Database Set POST", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {
        wilting.post(null, null);
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(), 'WiltException: message = No database specified');
      }

    });

    test("No Database Set PUT", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {
        wilting.put(null, "1");
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(), 'WiltException: message = No database specified');
      }

    });

    test("No Database Set DELETE", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {
        wilting.delete(null);
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(), 'WiltException: message = No database specified');
      }

    });

  });

  /* Group 3 - Document/Database methods parameter validation  */
  group("3. Document/Database Parameter Validation - ", () {


    test("Get Document no id", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {
        wilting.getDocument(null);
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = getDocument() must have a document id');
      }

    });


    test("Delete Document no id", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {
        wilting.deleteDocument(null, null);
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = deleteDocument() expects a document id and a revision.'
            );
      }

    });

    test("Delete Document no rev", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {
        wilting.deleteDocument("1", null);
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = deleteDocument() expects a document id and a revision.'
            );
      }

    });

    test("Put Document no id", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {
        jsonobject.JsonObject doc;
        wilting.putDocument(null, doc);
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = putDocument() expects a document id and a document body.'
            );
      }


    });

    test("Put Document no data", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {
        wilting.putDocument("1", null);
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = putDocument() expects a document id and a document body.'
            );
      }

    });

    test("Post Document no document body", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {
        jsonobject.JsonObject doc;
        wilting.postDocument(null);
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = postDocument() expects a document body.');
      }

    });

    test("Post Document String no document string", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {
        jsonobject.JsonObject doc;
        wilting.postDocumentString(null);
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = postDocumentString() expects a document body.');
      }


    });

    test("Create Database no name", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {
        wilting.createDatabase(null);
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = createDatabase() expects a database name.');
      }

    });

    test("Delete Database no name", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {
        wilting.deleteDatabase(null);
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = deleteDatabase() expects a database name.');
      }

    });

    test("All Docs invalid limit ", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {
        wilting.getAllDocs(limit: -1);
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = getAllDocs() must have a positive limit');
      }

    });

    test("Generate Ids invalid amount ", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {
        wilting.generateIds(-1);
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = generateIds() expects a positive amount.');
      }

    });

    test("Copy document no source id", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {
        wilting.copyDocument(null, '1');
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = copyDocument () expects a source id.');
      }

    });

    test("Copy document no destinationid", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {
        wilting.copyDocument('1', null);
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = copyDocument () expects a destination id.');
      }

    });

    test("Login null user name", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {
        wilting.login(null, "password");
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = Login() expects a non null user name and password');
      }

    });

    test("Login null password", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {
        wilting.login("name", null);
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = Login() expects a non null user name and password');
      }

    });

    test("Create Attachment no Doc Id", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {

        String payload = 'Hello';
        wilting.createAttachment(null, 'name', 'rev', 'image/png', payload);
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = createAttachment() expects a document id.');
      }

    });

    test("Create Attachment no Attachment name", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {

        String payload = 'Hello';
        wilting.createAttachment('id', null, 'rev', 'image/png', payload);
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = createAttachment() expects an attachment name.');
      }

    });

    test("Create Attachment no Revision", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {

        String payload = 'Hello';
        wilting.createAttachment('id', 'name', null, 'image/png', payload);
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = createAttachment() expects a revision.');
      }

    });

    test("Create Attachment no Content Type", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {

        String payload = 'Hello';
        wilting.createAttachment('id', 'name', 'rev', null, payload);
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = createAttachment() expects a content type.');
      }

    });

    test("Create Attachment no Payload", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {

        wilting.createAttachment('id', 'name', 'rev', 'image/png', null);
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = createAttachment() expects a payload.');
      }

    });

    test("Update Attachment no Doc Id", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {

        String payload = 'Hello';
        wilting.updateAttachment(null, 'name', 'rev', 'image/png', payload);
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = updateAttachment() expects a document id.');
      }

    });

    test("Update Attachment no Attachment name", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {

        String payload = 'Hello';
        wilting.updateAttachment('id', null, 'rev', 'image/png', payload);
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = updateAttachment() expects an attachment name.');
      }


    });

    test("Update Attachment no Revision", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {

        String payload = 'Hello';
        wilting.updateAttachment('id', 'name', null, 'image/png', payload);
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = updateAttachment() expects a revision.');
      }

    });

    test("Update Attachment no Content Type", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {

        String payload = 'Hello';
        wilting.updateAttachment('id', 'name', 'rev', null, payload);
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = updateAttachment() expects a content type.');
      }

    });

    test("Update Attachment no Payload", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {

        wilting.updateAttachment('id', 'name', 'rev', 'image/png', null);
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = updateAttachment() expects a payload.');
      }

    });

    test("Delete Attachment no Doc Id", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {

        wilting.deleteAttachment(null, 'name', 'rev');
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = deleteAttachment() expects a document id.');
      }

    });

    test("Delete Attachment no Attachment name", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {

        wilting.deleteAttachment('id', null, 'rev');
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = deleteAttachment() expects an attachment name.');
      }

    });

    test("Delete Attachment no Revision", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {

        wilting.deleteAttachment('id', 'name', null);
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = deleteAttachment() expects a revision.');
      }

    });

    test("Get Attachment no Doc Id", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {

        wilting.getAttachment(null, 'name');
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = getAttachment() expects a document id.');
      }

    });

    test("Get Attachment no Attachment name", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

      try {

        wilting.getAttachment('id', null);
      } catch (e) {

        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            'WiltException: message = getAttachment() expects an attachment name.');
      }

    });


  });

  /* Group 4 - Single documents and database methods */
  group("4. Single documents and database - ", () {

    /* Create our WiltBrowserClient */
    WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);


    /* Login if we are using authentication */
    if (userName != null) {

      wilting.login(userName, userPassword);
    }

    /*Group setup */
    String docId = null;
    String docRev = null;
    String putId = 'mytestid';
    String putId2 = 'mytestid2';
    String putId3 = 'mytestid3';
    String copyId = 'mycopyid';
    String returnedDocRev;

    test("Create Database not authorized", () {

      /* Create a local wilting for this test */
      WiltBrowserClient localWilting = new WiltBrowserClient(hostName, port,
          scheme);

      localWilting.login('freddy', 'freddypass');

      var completer = expectAsync0(() {

        jsonobject.JsonObject res = localWilting.completionResponse;
        expect(res.method, Wilt.CREATE_DATABASE);
        try {
          expect(res.error, isFalse);
        } catch (e) {

          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          expect(errorResponse.error, equals('unauthorized'));
          expect(errorResponse.reason, equals('Name or password is incorrect.')
              );
          expect(res.errorCode, equals(401));
        }

      });

      localWilting.resultCompletion = completer;
      localWilting.createDatabase(databaseNameClientCompletion);

    });

    /* Create the test database */
    test("Create Test Database", () {

      var completer = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.CREATE_DATABASE);
        try {
          expect(res.error, isFalse);
        } catch (e) {

          logMessage("WILT::Create Test Database Failed");
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");

        }

        jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        expect(successResponse.ok, isTrue);
      });

      wilting.resultCompletion = completer;
      wilting.createDatabase(databaseNameClientCompletion);


    });

    /* Create a database then delete it */
    test("Delete Database", () {

      var checkCompleter = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.DELETE_DATABASE);
        try {
          expect(res.error, isFalse);
        } catch (e) {

          logMessage("WILT::Delete Database check");
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");

        }

      });

      var completer = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.CREATE_DATABASE);
        try {
          expect(res.error, isFalse);
        } catch (e) {

          logMessage("WILT::Create Database Failed");
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");

        }

        /* Now delete it */
        wilting.resultCompletion = checkCompleter;
        wilting.deleteDatabase("wiltdeleteme");


      });

      wilting.resultCompletion = completer;
      wilting.createDatabase("wiltdeleteme");

    });


    test("HEAD null URL", () {

      var completer = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.HEAD);
        try {
          expect(res.error, isTrue);
        } catch (e) {

          logMessage("WILT::Head null URL");
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");

        }

      });

      wilting.resultCompletion = completer;
      wilting.db = databaseNameClientCompletion;
      wilting.head(null);


    });

    test("Create document(POST) and check", () {

      var checkCompleter = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.GET_DOCUMENT);
        try {
          expect(res.error, isFalse);
        } catch (e) {

          logMessage("WILT::Create Document(POST) and check creation");
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");

        }

        /* Check the documents parameters */
        jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        String returnedDocId = WiltUserUtils.getDocumentId(successResponse);
        expect(returnedDocId, docId);
        String returnedDocRev = WiltUserUtils.getDocumentRev(successResponse);
        expect(successResponse.title, equals("Created by a Post Request"));
        expect(successResponse.version, equals(1));
        expect(successResponse.author, equals("Me"));

      });

      var completer = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.POST_DOCUMENT);
        try {
          expect(res.error, isFalse);
        } catch (e) {

          logMessage("WILT::Create Document(POST) and check");
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          String responseHeaders = res.responseHeaders;
          logMessage("WILT::Response headers are $responseHeaders");

        }

        /* Get the documents id and re-get the document to check correctness */
        jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        docId = successResponse.id;
        expect(docId, isNot(isEmpty));
        /* Now get the document and check it */
        wilting.resultCompletion = checkCompleter;
        wilting.getDocument(docId);

      });

      wilting.resultCompletion = completer;
      wilting.db = databaseNameClientCompletion;
      jsonobject.JsonObject document = new jsonobject.JsonObject();
      document.title = "Created by a Post Request";
      document.version = 1;
      document.author = "Me";
      wilting.postDocument(document);

    });

    test("Create document(PUT) and check", () {

      var checkCompleter = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.GET_DOCUMENT);
        try {
          expect(res.error, isFalse);
        } catch (e) {

          logMessage("WILT::Create Document(PUT) and check updated");
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");

        }

        /* Check the documents parameters */
        jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        String returnedDocId = WiltUserUtils.getDocumentId(successResponse);
        expect(returnedDocId, putId);
        returnedDocRev = WiltUserUtils.getDocumentRev(successResponse);
        expect(successResponse.title, equals("Created by a Put Request"));
        expect(successResponse.version, equals(2));
        expect(successResponse.author, equals("Me again"));

      });

      var completer = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.PUT_DOCUMENT);
        try {
          expect(res.error, isFalse);
        } catch (e) {

          logMessage("WILT::Test Put Document and check");
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");

        }

        /* Get the documents id and re-get the document to check correctness */
        jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        String putDocId = successResponse.id;
        expect(putDocId, equals(putId));
        /* Now get the document and check it */
        wilting.resultCompletion = checkCompleter;
        wilting.getDocument(putId);

      });

      wilting.resultCompletion = completer;
      wilting.db = databaseNameClientCompletion;
      jsonobject.JsonObject document = new jsonobject.JsonObject();
      document.title = "Created by a Put Request";
      document.version = 2;
      document.author = "Me again";
      wilting.putDocument(putId, document);

    });

    test("Update document(PUT) and check", () {

      var checkUpdater = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.PUT_DOCUMENT);
        try {
          expect(res.error, isFalse);
        } catch (e) {

          logMessage("WILT::Update document and check updated");
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");

        }

        /* Check the documents parameters */
        jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        String returnedDocId = successResponse.id;
        expect(returnedDocId, equals(putId));
        String returnedDocRev = successResponse.rev;
        expect(returnedDocRev, isNot(equals(docRev)));

      });

      var checkCompleter = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        try {
          expect(res.error, isFalse);
        } catch (e) {

          logMessage("WILT::Update document and check created");
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");

        }

        /* Check the documents parameters */
        jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        String returnedDocId = WiltUserUtils.getDocumentId(successResponse);
        expect(returnedDocId, putId);
        String returnedDocRev = WiltUserUtils.getDocumentRev(successResponse);
        docRev = returnedDocRev;
        expect(successResponse.title, equals(
            "Created by a Put Request for checking"));
        expect(successResponse.version, equals(3));
        expect(successResponse.author, equals("Me also"));
        /* Now alter the document using putDocument */
        jsonobject.JsonObject document = new jsonobject.JsonObject();
        document.title = "Created by a Put Request for updating ";
        document.version = 4;
        document.author = "Me also and again";
        String docString = WiltUserUtils.addDocumentRev(document, returnedDocRev
            );
        wilting.resultCompletion = checkUpdater;
        wilting.putDocumentString(putId, docString);

      });

      var completer = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.PUT_DOCUMENT);
        try {
          expect(res.error, isFalse);
        } catch (e) {

          logMessage("WILT::Update document and check");
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");

        }

        /* Get the documents id and re-get the document to check correctness */
        jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        String putDocId = successResponse.id;
        expect(putDocId, equals(putId));
        /* Now get the document and check it */
        wilting.resultCompletion = checkCompleter;
        wilting.getDocument(putId);

      });

      wilting.resultCompletion = completer;
      wilting.db = databaseNameClientCompletion;
      jsonobject.JsonObject document = new jsonobject.JsonObject();
      document.title = "Created by a Put Request for checking";
      document.version = 3;
      document.author = "Me also";
      wilting.putDocument(putId, document, returnedDocRev);

    });

    test("Delete document and check ", () {

      var checkCompleter = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.DELETE_DOCUMENT);
        try {
          expect(res.error, isFalse);
        } catch (e) {

          logMessage("WILT::Delete document and check deletion");
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");

        }

        /* Check the document has been deleted */
        jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        String putDocId = successResponse.id;
        expect(putDocId, equals(putId3));
      });

      var completer = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.PUT_DOCUMENT);
        try {
          expect(res.error, isFalse);
        } catch (e) {

          logMessage("WILT::Delete document and check");
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");

        }

        /* Get the documents id and re-get the document to check correctness */
        jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        String putDocId = successResponse.id;
        expect(putDocId, equals(putId3));
        String returnedDocRev = successResponse.rev;
        /* Now delete the document and check it */
        wilting.resultCompletion = checkCompleter;
        wilting.deleteDocument(putId3, returnedDocRev);

      });

      wilting.resultCompletion = completer;
      wilting.db = databaseNameClientCompletion;
      jsonobject.JsonObject document = new jsonobject.JsonObject();
      document.title = "Created by a Put Request for deleting";
      document.version = 1;
      document.author = "Its me again";
      wilting.putDocument(putId3, document);

    });

    test("Copy document", () {

      var completer = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.COPY_DOCUMENT);
        try {
          expect(res.error, isFalse);
        } catch (e) {

          logMessage("WILT::Copy document");
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");

        }

        /* Check the copied document */
        jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        String copyDocId = successResponse.id;
        expect(copyDocId, equals(copyId));

      });

      wilting.resultCompletion = completer;
      wilting.db = databaseNameClientCompletion;
      wilting.copyDocument(putId, copyId);

    });



    /* Raw HTTP Request */
    test("Raw HTTP Request", () {

      var completer = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        try {
          expect(res.error, isFalse);
        } catch (e) {

          logMessage("WILT::Raw HTTP Request failed");
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");

        }

        jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        String returnedDocId = WiltUserUtils.getDocumentId(successResponse);
        expect(returnedDocId, putId);

      });

      wilting.resultCompletion = completer;
      String url = "/$databaseNameClientCompletion/$putId";
      wilting.httpRequest(url);

    });

  });

  /* Group 5 - Bulk documents */
  group("5. Bulk Documents - ", () {


    /* Create our WiltBrowserClient */
    WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

    /* Login if we are using authentication */
    if (userName != null) {

      wilting.login(userName, userPassword);
    }

    /* Setup */
    String docId = null;
    String docRev = null;
    String putId = 'mytestid';
    String putId2 = 'mytestid2';
    String putId3 = 'mytestid3';
    String copyId = 'mycopyid';

    test("Get All Docs  - Include docs", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);


      var completer = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.GET_ALLDOCS);
        try {
          expect(res.error, isFalse);
        } catch (e) {

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
        expect(successResponse.total_rows, equals(3));
        expect(successResponse.rows[1].id, equals(copyId));
        expect(successResponse.rows[2].id, equals(putId));

      });

      wilting.resultCompletion = completer;
      wilting.db = databaseNameClientCompletion;
      wilting.getAllDocs(includeDocs: true);


    });

    test("Get All Docs  - limit", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);


      var completer = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.GET_ALLDOCS);
        try {
          expect(res.error, isFalse);
        } catch (e) {

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
        expect(successResponse.total_rows, equals(3));
        expect(successResponse.rows[0].id, isNot(equals(putId)));
        expect(successResponse.rows[0].id, isNot(equals(putId2)));
        int count = 0;
        for (final x in successResponse.rows) {

          count++;
        }
        expect(count, equals(1));

      });

      wilting.resultCompletion = completer;
      wilting.db = databaseNameClientCompletion;
      wilting.getAllDocs(limit: 1);


    });


    test("Get All Docs  - start key", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);


      var completer = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.GET_ALLDOCS);
        try {
          expect(res.error, isFalse);
        } catch (e) {

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
        expect(successResponse.total_rows, equals(3));
        expect(successResponse.rows[0].id, equals(putId));
        int count = 0;
        for (final x in successResponse.rows) {

          count++;
        }
        expect(count, equals(1));

      });

      wilting.resultCompletion = completer;
      wilting.db = databaseNameClientCompletion;
      wilting.getAllDocs(startKey: putId);


    });

    test("Get All Docs  - end key", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);


      var completer = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.GET_ALLDOCS);
        try {
          expect(res.error, isFalse);
        } catch (e) {

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
        expect(successResponse.total_rows, equals(3));
        expect(successResponse.rows[1].id, equals(copyId));
        int count = 0;
        for (final x in successResponse.rows) {

          count++;
        }
        expect(count, equals(3));

      });

      wilting.resultCompletion = completer;
      wilting.db = databaseNameClientCompletion;
      wilting.getAllDocs(endKey: putId2);


    });

    test("Get All Docs - key list", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);


      var completer = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.GET_ALLDOCS);
        try {
          expect(res.error, isFalse);
        } catch (e) {

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
        expect(successResponse.total_rows, equals(3));
        expect(successResponse.rows[0].id, equals(putId));
        expect(successResponse.rows[1].key, equals(putId2));
        int count = 0;
        for (final x in successResponse.rows) {

          count++;
        }
        expect(count, equals(2));

      });

      wilting.resultCompletion = completer;
      wilting.db = databaseNameClientCompletion;
      List keyList = new List<String>();
      keyList.add(putId);
      keyList.add(putId2);
      wilting.getAllDocs(keys: keyList);


    });

    test("Get All Docs  - descending", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);


      var completer = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.GET_ALLDOCS);
        try {
          expect(res.error, isFalse);
        } catch (e) {

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
        expect(successResponse.total_rows, equals(3));
        expect(successResponse.rows[1].id, equals(putId));
        expect(successResponse.rows[0].key, equals(putId2));
        int count = 0;
        for (final x in successResponse.rows) {

          count++;
        }
        expect(count, equals(2));

      });

      wilting.resultCompletion = completer;
      wilting.db = databaseNameClientCompletion;
      List keyList = new List<String>();
      keyList.add(putId);
      keyList.add(putId2);
      wilting.getAllDocs(keys: keyList, descending: true);


    });

    test("Bulk Insert Auto Keys", () {

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);


      var completer = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.BULK);
        try {
          expect(res.error, isFalse);
        } catch (e) {

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
      wilting.db = databaseNameClientCompletion;
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

      WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);


      var completer = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.BULK_STRING);
        try {
          expect(res.error, isFalse);
        } catch (e) {

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
      wilting.db = databaseNameClientCompletion;

      jsonobject.JsonObject document1 = new jsonobject.JsonObject();
      document1.title = "Document 1";
      document1.version = 1;
      document1.attribute = "Doc 1 attribute";
      String doc1 = WiltUserUtils.addDocumentId(document1, "MyBulkId1");
      jsonobject.JsonObject document2 = new jsonobject.JsonObject();
      document2.title = "Document 2";
      document2.version = 2;
      document2.attribute = "Doc 2 attribute";
      String doc2 = WiltUserUtils.addDocumentId(document2, "MyBulkId2");
      jsonobject.JsonObject document3 = new jsonobject.JsonObject();
      document3.title = "Document 3";
      document3.version = 3;
      document3.attribute = "Doc 3 attribute";
      String doc3 = WiltUserUtils.addDocumentId(document3, "MyBulkId3");
      List docList = new List<String>();
      docList.add(doc1);
      docList.add(doc2);
      docList.add(doc3);
      String docs = WiltUserUtils.createBulkInsertString(docList);
      wilting.bulkString(docs);

    });

  });

  /* Group 6 - Information tests */
  group("Information/Utilty Tests - ", () {

    /* Create our WiltBrowserClient */
    WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

    /* Login if we are using authentication */
    if (userName != null) {

      wilting.login(userName, userPassword);
    }

    test("Get Session Information", () {

      var completer = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.GET_SESSION);
        try {
          expect(res.error, isFalse);
        } catch (e) {

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

      });

      wilting.resultCompletion = completer;
      wilting.getSession();

    });

    test("Get Stats Information", () {

      var completer = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.GET_STATS);
        try {
          expect(res.error, isFalse);
        } catch (e) {

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

      });

      wilting.resultCompletion = completer;
      wilting.getStats();

    });

    test("Get Database Information - default", () {

      var completer = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.DATABASE_INFO);
        try {
          expect(res.error, isFalse);
        } catch (e) {

          logMessage("WILT::Get Database Information - default");
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
        expect(successResponse.db_name, equals(databaseNameClientCompletion));

      });

      wilting.resultCompletion = completer;
      wilting.db = databaseNameClientCompletion;
      wilting.getDatabaseInfo();

    });

    test("Get Database Information - specified", () {

      var completer = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.DATABASE_INFO);
        try {
          expect(res.error, isFalse);
        } catch (e) {

          logMessage("WILT::Get Database Information - specified");
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
        expect(successResponse.db_name, equals(databaseNameClientCompletion));

      });

      wilting.resultCompletion = completer;
      wilting.getDatabaseInfo(databaseNameClientCompletion);

    });

    test("Get All DB's", () {

      var completer = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.GET_ALLDBS);
        try {
          expect(res.error, isFalse);
        } catch (e) {

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
        expect(successResponse.contains(databaseNameClientCompletion), isTrue);

      });

      wilting.resultCompletion = completer;
      wilting.getAllDbs();

    });

    test("Generate Ids", () {

      var completer = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.GENERATE_IDS);
        try {
          expect(res.error, isFalse);
        } catch (e) {

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

      });

      wilting.resultCompletion = completer;
      wilting.generateIds(10);

    });

  });

  /* Group 7 - Attachment tests */
  group("Attachment Tests - ", () {

    /* Create our WiltBrowserClient */
    WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);

    /* Login if we are using authentication */
    if (userName != null) {

      wilting.login(userName, userPassword);
    }

    /* Globals for the group */
    String testDocRev = null;
    String pngImage = 'iVBORw0KGgoAAAANSUhEUgAAABwAAAASCAMAAAB/2U7WAAAABl' +
        'BMVEUAAAD///+l2Z/dAAAASUlEQVR4XqWQUQoAIAxC2/0vXZDr' +
        'EX4IJTRkb7lobNUStXsB0jIXIAMSsQnWlsV+wULF4Avk9fLq2r' +
        '8a5HSE35Q3eO2XP1A1wQkZSgETvDtKdQAAAABJRU5ErkJggg==';

    String pngImageUpdate = 'iVBORw0KGgoAAAANSUhEUgAAABwAAAASCAMAAAB/2U7WAAAABl'
        + 'BMVEUAAAD///+l2Z/dAAAASUlEQVR4XqWQUQoAIAxC2/0vXZDr' +
        'EX4IJTRkb7lobNUStXsB0jIXIAMSsQnWlsV+wULF4Avk9fLq2r' +
        '8a5HSE35Q3eO2XP1A1wQkZSgETvDtKdQAAAABJRU5ErkJggg!!';

    test("Create document(PUT) for attachment tests and check", () {

      var checkCompleter = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.GET_DOCUMENT);
        try {
          expect(res.error, isFalse);
        } catch (e) {

          logMessage(
              "WILT::Create Document(PUT) for attachment tests and check updated");
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");

        }

        /* Check the documents parameters */
        jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        String returnedDocId = WiltUserUtils.getDocumentId(successResponse);
        expect(returnedDocId, 'attachmentTestDoc');
        testDocRev = WiltUserUtils.getDocumentRev(successResponse);
        expect(successResponse.title, equals(
            "Created by a Put Request for attachment testing"));
        expect(successResponse.version, equals(1));
        expect(successResponse.author, equals("SJH"));

      });

      var completer = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.PUT_DOCUMENT);
        try {
          expect(res.error, isFalse);
        } catch (e) {

          logMessage("WILT::Test Put Document for attachment tests and check");
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");

        }

        /* Get the documents id and re-get the document to check correctness */
        jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        String putDocId = successResponse.id;
        expect(putDocId, equals('attachmentTestDoc'));
        /* Now get the document and check it */
        wilting.resultCompletion = checkCompleter;
        wilting.getDocument('attachmentTestDoc');

      });

      wilting.resultCompletion = completer;
      wilting.db = databaseNameClientCompletion;
      jsonobject.JsonObject document = new jsonobject.JsonObject();
      document.title = "Created by a Put Request for attachment testing";
      document.version = 1;
      document.author = "SJH";
      wilting.putDocument('attachmentTestDoc', document);

    });

    test("Create Attachment", () {

      var completer = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.CREATE_ATTACHMENT);
        try {
          expect(res.error, isFalse);
        } catch (e) {

          logMessage("WILT::Create Attachment Failed");
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
        testDocRev = WiltUserUtils.getDocumentRev(successResponse);

      });

      wilting.resultCompletion = completer;
      wilting.db = databaseNameClientCompletion;
      wilting.createAttachment('attachmentTestDoc', 'attachmentName',
          testDocRev, 'image/png', pngImage);

    });

    test("Get Create Attachment", () {

      var revisionCompleter = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.GET_DOCUMENT);
        try {
          expect(res.error, isFalse);
        } catch (e) {

          logMessage("WILT::Get Create Attachment Get Document Revision");
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");

        }

        /* Check the documents parameters */
        jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        String returnedDocId = WiltUserUtils.getDocumentId(successResponse);
        expect(returnedDocId, 'attachmentTestDoc');
        testDocRev = WiltUserUtils.getDocumentRev(successResponse);
        expect(successResponse.title, equals(
            "Created by a Put Request for attachment testing"));
        expect(successResponse.version, equals(1));
        expect(successResponse.author, equals("SJH"));
        List attachments = WiltUserUtils.getAttachments(successResponse);
        expect(attachments[0].name, 'attachmentName');
        expect(attachments[0].data.content_type, 'image/png');
        expect(attachments[0].data.length, anything);
        expect(window.atob(attachments[0].data.data), pngImage);

      });

      var completer = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.GET_ATTACHMENT);
        try {
          expect(res.error, isFalse);
        } catch (e) {

          logMessage("WILT::Get Create Attachment Failed");
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
        String payload = res.responseText;
        expect(payload, equals(pngImage));
        String contentType = successResponse.contentType;
        expect(contentType, equals('image/png'));
        /* Now get the document to get the new revision along
         * with its attachment data 
         */
        wilting.resultCompletion = revisionCompleter;
        wilting.getDocument('attachmentTestDoc', null, true);

      });

      wilting.resultCompletion = completer;
      wilting.db = databaseNameClientCompletion;
      wilting.getAttachment('attachmentTestDoc', 'attachmentName');


    });

    test("Update Attachment", () {

      var completer = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.UPDATE_ATTACHMENT);
        try {
          expect(res.error, isFalse);
        } catch (e) {

          logMessage("WILT::Update Attachment Failed");
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


      });

      wilting.resultCompletion = completer;
      wilting.db = databaseNameClientCompletion;
      wilting.updateAttachment('attachmentTestDoc', 'attachmentName',
          testDocRev, 'image/png', pngImageUpdate);

    });

    test("Get Update Attachment", () {

      var revisionCompleter = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.GET_DOCUMENT);
        try {
          expect(res.error, isFalse);
        } catch (e) {

          logMessage("WILT::Get Update Attachment Get Document Revision");
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");

        }

        /* Check the documents parameters */
        jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        String returnedDocId = WiltUserUtils.getDocumentId(successResponse);
        expect(returnedDocId, 'attachmentTestDoc');
        testDocRev = WiltUserUtils.getDocumentRev(successResponse);
        expect(successResponse.title, equals(
            "Created by a Put Request for attachment testing"));
        expect(successResponse.version, equals(1));
        expect(successResponse.author, equals("SJH"));

      });

      var completer = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.GET_ATTACHMENT);
        try {
          expect(res.error, isFalse);
        } catch (e) {

          logMessage("WILT::Get Update Attachment Failed");
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
        testDocRev = WiltUserUtils.getDocumentRev(successResponse);
        String payload = res.responseText;
        expect(payload, equals(pngImageUpdate));
        String contentType = successResponse.contentType;
        expect(contentType, equals('image/png'));
        /* Now get the document to get the new revision  */
        wilting.resultCompletion = revisionCompleter;
        wilting.getDocument('attachmentTestDoc');

      });

      wilting.resultCompletion = completer;
      wilting.db = databaseNameClientCompletion;
      wilting.getAttachment('attachmentTestDoc', 'attachmentName');


    });

    test("Create Attachment With New Document", () {

      var completer = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.CREATE_ATTACHMENT);
        try {
          expect(res.error, isFalse);
        } catch (e) {

          logMessage("WILT::Create Attachment Failed");
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

      });

      wilting.resultCompletion = completer;
      wilting.db = databaseNameClientCompletion;
      wilting.createAttachment('anotherAttachmentTestDoc', 'attachmentName', '',
          'image/png', pngImage);

    });

    test("Create Attachment Invalid Revision", () {

      var completer = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.CREATE_ATTACHMENT);
        expect(res.error, isTrue);
        int statusCode = res.errorCode;
        expect(statusCode, equals(409));

      });

      wilting.resultCompletion = completer;
      wilting.db = databaseNameClientCompletion;
      wilting.createAttachment('attachmentTestDoc', 'anotherAttachmentName',
          '1-bb48c078f0fac47234e774a7a51b86ac', 'image/png', pngImage);

    });

    test("Delete Attachment", () {

      var completer = expectAsync0(() {

        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.DELETE_ATTACHMENT);
        try {
          expect(res.error, isFalse);
        } catch (e) {

          logMessage("WILT::Delete Attachment Failed");
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

      });

      wilting.resultCompletion = completer;
      wilting.db = databaseNameClientCompletion;
      wilting.deleteAttachment('attachmentTestDoc', 'attachmentName', testDocRev
          );

    });

  });

  /* Group 8 - Change Notifications */
  group("Change Notification Tests - ", () {

    String pngImage = 'iVBORw0KGgoAAAANSUhEUgAAABwAAAASCAMAAAB/2U7WAAAABl' +
        'BMVEUAAAD///+l2Z/dAAAASUlEQVR4XqWQUQoAIAxC2/0vXZDr' +
        'EX4IJTRkb7lobNUStXsB0jIXIAMSsQnWlsV+wULF4Avk9fLq2r' +
        '8a5HSE35Q3eO2XP1A1wQkZSgETvDtKdQAAAABJRU5ErkJggg==';

    /* Create our WiltBrowserClient */
    WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, scheme);
    wilting.db = databaseNameClientCompletion;

    /* Login if we are using authentication */
    if (userName != null) {

      wilting.login(userName, userPassword);
    }

    test("Start Change Notification", () {

      void wrapper() {

        wilting.startChangeNotification();

      }

      expect(wrapper, returnsNormally);

    });

    test("Check Change Notifications", () {

      int count = 0;

      var completer = expectAsync0(() {

        wilting.stopChangeNotification();
        expect(count, 11);

      });

      wilting.changeNotification.listen((e) {

        count++;
        if (e.docId == 'mytestid2') expect(e.type,
            WiltChangeNotificationEvent.UPDATE);
        if (e.docId == 'mytestid3') expect(e.type,
            WiltChangeNotificationEvent.DELETE);
        if (e.docId == 'anotherAttachmentTestDoc') completer();

      });

    });

    test("Start Change Notification With Docs and Attachments", () {

      WiltChangeNotificationParameters parameters =
          new WiltChangeNotificationParameters();
      parameters.includeDocs = true;
      parameters.includeAttachments = true;
      void wrapper() {

        wilting.startChangeNotification(parameters);

      }

      expect(wrapper, returnsNormally);

    });

    test("Check Change Notifications With Docs", () {

      int count = 0;

      var completer = expectAsync0(() {

        expect(count, 11);

      });

      wilting.changeNotification.listen((e) {

        count++;
        if (e.docId == 'mytestid2') {

          expect(e.type, WiltChangeNotificationEvent.UPDATE);
          jsonobject.JsonObject document = e.document;
          expect(document.title, "Created by a Put Request for updating ");
          expect(document.version, 4);
          expect(document.author, "Me also and again");

        }
        if (e.docId == 'mytestid3') expect(e.type,
            WiltChangeNotificationEvent.DELETE);
        if (e.docId == 'anotherAttachmentTestDoc') {

          /* Only version 1.6 
          List attachments = WiltUserUtils.getAttachments(e.document);
          expect(attachments[0].data, pngImage); */
          completer();

        }

      });

    });

    test("Notification Pause", () {

      int count = 0;

      var completer = expectAsync0(() {

        expect(count, 3);
        wilting.pauseChangeNotifications();

      });

      wilting.changeNotification.listen((e) {

        count++;
        expect(e.type, WiltChangeNotificationEvent.LAST_SEQUENCE);
        if (count == 3) completer();

      });

    });

    test("Check Notification Pause", () {

      int resLength = -1;

      var completer = expectAsync0(() {

        expect(wilting.changeNotificationsPaused, true);

      });

      completer();

    });

    test("Notification Restart", () {

      int count = 0;

      var completer = expectAsync0(() {

        expect(wilting.changeNotificationsPaused, false);
        expect(count, 3);
        wilting.stopChangeNotification();

      });

      wilting.restartChangeNotifications();
      wilting.changeNotification.listen((e) {

        count++;
        expect(e.type, WiltChangeNotificationEvent.LAST_SEQUENCE);
        if (count == 3) completer();

      });

    });

  });

}
