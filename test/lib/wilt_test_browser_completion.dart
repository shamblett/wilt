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
            WiltException.HEADER + WiltException.BAD_CONST_PARAMS);
      }
    });

    test("No port", () {
      try {
        WiltBrowserClient wilting =
        new WiltBrowserClient(hostName, null, scheme);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.BAD_CONST_PARAMS);
      }
    });

    test("No Scheme", () {
      try {
        WiltBrowserClient wilting = new WiltBrowserClient(hostName, port, null);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.BAD_CONST_PARAMS);
      }
    });

    test("No HTTP Adapter", () {
      try {
        WiltBrowserClient wilting =
        new WiltBrowserClient(hostName, port, scheme, null);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.BAD_CONST_NO_ADAPTER);
      }
    });
  });

  /* Group 2 - Basic methods parameter validation  */
  group("2. Basic Methods Parameter Validation - ", () {
    var completer = (_) {};

    test("No Database Set HEAD", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        wilting.head(null);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.NO_DATABASE_SPECIFIED);
      }
    });

    test("No Database Set GET", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        wilting.get(null);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.NO_DATABASE_SPECIFIED);
      }
    });

    test("No Database Set POST", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        wilting.post(null, null);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.NO_DATABASE_SPECIFIED);
      }
    });

    test("No Database Set PUT", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        wilting.put(null, "1");
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.NO_DATABASE_SPECIFIED);
      }
    });

    test("No Database Set DELETE", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        wilting.delete(null);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.NO_DATABASE_SPECIFIED);
      }
    });
  });

  /* Group 3 - Document/Database methods parameter validation  */
  group("3. Document/Database Parameter Validation - ", () {
    var completer = (_) {};

    test("Get Document no id", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        wilting.getDocument(null);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.HEADER + WiltException.GET_DOC_NO_ID);
      }
    });

    test("Delete Document no id", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        wilting.deleteDocument(null, null);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.DELETE_DOC_NO_ID_REV);
      }
    });

    test("Delete Document no rev", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        wilting.deleteDocument("1", null);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.DELETE_DOC_NO_ID_REV);
      }
    });

    test("Put Document no id", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        jsonobject.JsonObject doc;
        wilting.putDocument(null, doc);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.PUT_DOC_NO_ID_BODY);
      }
    });

    test("Put Document no data", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        wilting.putDocument("1", null);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.PUT_DOC_NO_ID_BODY);
      }
    });

    test("Post Document no document body", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        jsonobject.JsonObject doc;
        wilting.postDocument(null);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.POST_DOC_NO_BODY);
      }
    });

    test("Post Document String no document string", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        jsonobject.JsonObject doc;
        wilting.postDocumentString(null);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.POST_DOC_STRING_NO_BODY);
      }
    });

    test("Create Database no name", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        wilting.createDatabase(null);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.CREATE_DB_NO_NAME);
      }
    });

    test("Delete Database no name", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        wilting.deleteDatabase(null);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.DELETE_DB_NO_NAME);
      }
    });

    test("All Docs invalid limit ", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        wilting.getAllDocs(limit: -1);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.GET_ALL_DOCS_LIMIT);
      }
    });

    test("Generate Ids invalid amount ", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        wilting.generateIds(-1);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.HEADER + WiltException.GEN_IDS_AMOUNT);
      }
    });

    test("Copy document no source id", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        wilting.copyDocument(null, '1');
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.COPY_DOC_NO_SRC_ID);
      }
    });

    test("Copy document no destinationid", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        wilting.copyDocument('1', null);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.COPY_DOC_NO_DEST_ID);
      }
    });

    test("Login null user name", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        wilting.login(null, "password");
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.LOGIN_WRONG_PARAMS);
      }
    });

    test("Login null password", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        wilting.login("name", null);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.LOGIN_WRONG_PARAMS);
      }
    });

    test("Create Attachment no Doc Id", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        String payload = 'Hello';
        wilting.createAttachment(null, 'name', 'rev', 'image/png', payload);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.CREATE_ATT_NO_DOC_ID);
      }
    });

    test("Create Attachment no Attachment name", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        String payload = 'Hello';
        wilting.createAttachment('id', null, 'rev', 'image/png', payload);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.CREATE_ATT_NO_NAME);
      }
    });

    test("Create Attachment no Revision", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        String payload = 'Hello';
        wilting.createAttachment('id', 'name', null, 'image/png', payload);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.CREATE_ATT_NO_REV);
      }
    });

    test("Create Attachment no Content Type", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        String payload = 'Hello';
        wilting.createAttachment('id', 'name', 'rev', null, payload);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.CREATE_ATT_NO_CONTENT_TYPE);
      }
    });

    test("Create Attachment no Payload", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        wilting.createAttachment('id', 'name', 'rev', 'image/png', null);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.CREATE_ATT_NO_PAYLOAD);
      }
    });

    test("Update Attachment no Doc Id", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        String payload = 'Hello';
        wilting.updateAttachment(null, 'name', 'rev', 'image/png', payload);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.UPDATE_ATT_NO_DOC_ID);
      }
    });

    test("Update Attachment no Attachment name", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        String payload = 'Hello';
        wilting.updateAttachment('id', null, 'rev', 'image/png', payload);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.UPDATE_ATT_NO_NAME);
      }
    });

    test("Update Attachment no Revision", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        String payload = 'Hello';
        wilting.updateAttachment('id', 'name', null, 'image/png', payload);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.UPDATE_ATT_NO_REV);
      }
    });

    test("Update Attachment no Content Type", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        String payload = 'Hello';
        wilting.updateAttachment('id', 'name', 'rev', null, payload);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.UPDATE_ATT_NO_CONTENT_TYPE);
      }
    });

    test("Update Attachment no Payload", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        wilting.updateAttachment('id', 'name', 'rev', 'image/png', null);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.UPDATE_ATT_NO_PAYLOAD);
      }
    });

    test("Delete Attachment no Doc Id", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        wilting.deleteAttachment(null, 'name', 'rev');
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.DELETE_ATT_NO_DOC_ID);
      }
    });

    test("Delete Attachment no Attachment name", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        wilting.deleteAttachment('id', null, 'rev');
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.DELETE_ATT_NO_NAME);
      }
    });

    test("Delete Attachment no Revision", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        wilting.deleteAttachment('id', 'name', null);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.DELETE_ATT_NO_REV);
      }
    });

    test("Get Attachment no Doc Id", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        wilting.getAttachment(null, 'name');
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.HEADER + WiltException.GET_ATT_NO_DOC_ID);
      }
    });

    test("Get Attachment no Attachment name", () {
      WiltBrowserClient wilting =
      new WiltBrowserClient(hostName, port, scheme, completer);

      try {
        wilting.getAttachment('id', null);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.HEADER + WiltException.GET_ATT_NO_NAME);
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
      WiltBrowserClient localWilting =
      new WiltBrowserClient(hostName, port, scheme);

      localWilting.login('freddy', 'freddypass');

      var completer = expectAsync0(() {
        jsonobject.JsonObject res = localWilting.completionResponse;
        expect(res.method, Wilt.createDatabasee);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          expect(errorResponse.error, equals('unauthorized'));
          expect(
              errorResponse.reason, equals('Name or password is incorrect.'));
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
        expect(res.method, Wilt.createDatabasee);
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
        expect(res.method, Wilt.deleteDatabasee);
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
        expect(res.method, Wilt.createDatabasee);
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
        expect(res.method, Wilt.headd);
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
        expect(res.method, Wilt.getDocumentt);
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
        expect(res.method, Wilt.postDocumentt);
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
        expect(res.method, Wilt.getDocumentt);
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
        expect(res.method, Wilt.putDocumentt);
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
        expect(res.method, Wilt.putDocumentt);
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
        docRev = returnedDocRev;
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
        expect(successResponse.title,
            equals("Created by a Put Request for checking"));
        expect(successResponse.version, equals(3));
        expect(successResponse.author, equals("Me also"));
        /* Now alter the document using putDocument */
        jsonobject.JsonObject document = new jsonobject.JsonObject();
        document.title = "Created by a Put Request for updating ";
        document.version = 4;
        document.author = "Me also and again";
        String docString =
        WiltUserUtils.addDocumentRev(document, returnedDocRev);
        wilting.resultCompletion = checkUpdater;
        wilting.putDocumentString(putId, docString);
      });

      var completer = expectAsync0(() {
        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.putDocumentt);
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

    test("Get document revision and check ", () {
      wilting.db = databaseNameServer;
      wilting.getDocumentRevision(putId)
        ..then((rev) {
          expect(rev == docRev, true);
        });
    });

    test("Delete document and check ", () {
      var checkCompleter = expectAsync0(() {
        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.deleteDocumentt);
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
        expect(res.method, Wilt.putDocumentt);
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

    test("Delete document preserve and check ", () {
      var checkCompleter = expectAsync1((res) {
        expect(res.method, Wilt.putDocumentt);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Delete document preserve and check deletion");
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
        expect(putDocId, equals(putId2));
      });

      var completer = expectAsync1((res) {
        expect(res.method, Wilt.putDocumentt);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Delete document preserve and check");
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
        expect(putDocId, equals(putId2));
        String returnedDocRev = successResponse.rev;
        /* Now delete the document and check it */
        wilting.deleteDocument(putId2, returnedDocRev, true)
          ..then((res) {
            checkCompleter(res);
          });
      });

      wilting.resultCompletion = completer;
      wilting.db = databaseNameServer;
      jsonobject.JsonObject document = new jsonobject.JsonObject();
      document.title = "Created by a Put Request for preserve deleting";
      document.version = 1;
      document.author = "Its me again";
      wilting.putDocument(putId2, document);
    });

    test("Copy document", () {
      var completer = expectAsync0(() {
        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.copyDocumentt);
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
    test("User Utils  - Various", () {
      String id = "myId";
      String rev = "1-765frd";
      jsonobject.JsonObject record = new jsonobject.JsonObject();
      record.name = "Steve";
      record.tag = "MyTag";
      jsonobject.JsonObject record2 = record;

      record = WiltUserUtils.addDocumentIdJo(record, id);
      String tmp = record.toString();
      expect(tmp.contains('_id'), true);
      expect(tmp.contains(id), true);

      record = WiltUserUtils.addDocumentRevJo(record, rev);
      tmp = record.toString();
      expect(tmp.contains('_rev'), true);
      expect(tmp.contains(rev), true);

      record2 = WiltUserUtils.addDocumentIdRevJojsonobject(record, id, rev);
      tmp = record.toString();
      expect(tmp.contains('_rev'), true);
      expect(tmp.contains(rev), true);
      expect(tmp.contains('_id'), true);
      expect(tmp.contains(id), true);

      record2.name = "newName";
      record2.tag = "2-uy6543";
      List<jsonobject.JsonObject> jList = [record, record2];
      String bulk = WiltUserUtils.createBulkInsertStringJo(jList);
      expect(bulk, isNotNull);
      expect(bulk,
          '{"docs":[ {"name":"Steve","tag":"MyTag","_id":"myId","_rev":"1-765frd"},{"name":"newName","tag":"2-uy6543","_id":"myId","_rev":"1-765frd"}]}');
    });

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
        expect(res.method, Wilt.getAllDocss);
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
        expect(res.method, Wilt.getAllDocss);
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
        expect(res.method, Wilt.getAllDocss);
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
        expect(res.method, Wilt.getAllDocss);
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
        expect(res.method, Wilt.getAllDocss);
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
        expect(res.method, Wilt.getAllDocss);
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
        expect(res.method, Wilt.bulkk);
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
        expect(res.method, Wilt.bulkStringg);
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
        expect(res.method, Wilt.getSessionn);
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
        expect(res.method, Wilt.getStatss);
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
        expect(res.method, Wilt.databaseInfo);
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
        expect(res.method, Wilt.databaseInfo);
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
        expect(res.method, Wilt.getAllDbss);
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
      var completer = expectAsync1((res) {
        expect(res.method, Wilt.generateIdss);
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

    String pngImageUpdate =
        'iVBORw0KGgoAAAANSUhEUgAAABwAAAASCAMAAAB/2U7WAAAABl' +
            'BMVEUAAAD///+l2Z/dAAAASUlEQVR4XqWQUQoAIAxC2/0vXZDr' +
            'EX4IJTRkb7lobNUStXsB0jIXIAMSsQnWlsV+wULF4Avk9fLq2r' +
            '8a5HSE35Q3eO2XP1A1wQkZSgETvDtKdQAAAABJRU5ErkJggg!!';

    test("Create document(PUT) for attachment tests and check", () {
      var checkCompleter = expectAsync0(() {
        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.getDocumentt);
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
        expect(successResponse.title,
            equals("Created by a Put Request for attachment testing"));
        expect(successResponse.version, equals(1));
        expect(successResponse.author, equals("SJH"));
      });

      var completer = expectAsync0(() {
        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.putDocumentt);
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
        expect(res.method, Wilt.createAttachmentt);
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
        expect(res.method, Wilt.getDocumentt);
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
        expect(successResponse.title,
            equals("Created by a Put Request for attachment testing"));
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
        expect(res.method, Wilt.getAttachmentt);
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
        expect(res.method, Wilt.updateAttachmentt);
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
        expect(res.method, Wilt.getDocumentt);
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
        expect(successResponse.title,
            equals("Created by a Put Request for attachment testing"));
        expect(successResponse.version, equals(1));
        expect(successResponse.author, equals("SJH"));
      });

      var completer = expectAsync0(() {
        jsonobject.JsonObject res = wilting.completionResponse;
        expect(res.method, Wilt.getAttachmentt);
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
        expect(res.method, Wilt.createAttachmentt);
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
        expect(res.method, Wilt.createAttachmentt);
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
        expect(res.method, Wilt.deleteAttachmentt);
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
      wilting.deleteAttachment(
          'attachmentTestDoc', 'attachmentName', testDocRev);
    });
  });
}
