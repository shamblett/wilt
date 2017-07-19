/*
 * Package : WiltServerClient
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 04/06/2013
 * Copyright :  S.Hamblett@OSCF
 */

library wilt_server_test;

import 'package:wilt/wilt.dart';
import 'package:wilt/wilt_server_client.dart';
import 'package:json_object/json_object.dart' as jsonobject;
import 'package:test/test.dart';
import 'package:cryptoutils/cryptoutils.dart';
import 'wilt_test_config.dart';

void main() {
  /* Helper functions */
  void logMessage(String message) {
    print(message);
  }

  /* Tests */

  /* Group 1 - WiltServerClient constructor tests */
  group("1. Constructor Tests - ", () {
    test("No hostname", () {
      try {
        final WiltServerClient wilting =
            new WiltServerClient(null, serverPort, scheme);
        wilting.toString();
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.badConstParams);
      }
    });

    test("No port", () {
      try {
        final WiltServerClient wilting =
            new WiltServerClient(hostName, null, scheme);
        wilting.toString();
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.badConstParams);
      }
    });

    test("No Scheme", () {
      try {
        final WiltServerClient wilting =
            new WiltServerClient(hostName, serverPort, null);
        wilting.toString();
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.badConstParams);
      }
    });

    test("No HTTP Adapter", () {
      try {
        final WiltServerClient wilting =
            new WiltServerClient(hostName, serverPort, scheme, null);
        wilting.toString();
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.badConstNoAdapter);
      }
    });
  }, skip: false);

  /* Group 2 - Basic methods parameter validation  */
  group("2. Basic Methods Parameter Validation - ", () {
    test("No Database Set HEAD", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.noDatabaseSpecified);
      });

      wilting.head(null).then((jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("No Database Set GET", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.noDatabaseSpecified);
      });

      wilting.get(null).then((jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("No Database Set POST", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.noDatabaseSpecified);
      });

      wilting.post(null, "1").then((jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("No Database Set PUT", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.noDatabaseSpecified);
      });

      wilting.put(null, "1").then((jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("No Database Set DELETE", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.noDatabaseSpecified);
      });

      wilting.delete(null).then((jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });
  }, skip: false);

  /* Group 3 - Document/Database methods parameter validation  */
  group("3. Document/Database Parameter Validation - ", () {
    test("Get Document no id", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(), WiltException.header + WiltException.getDocNoId);
      });

      wilting.getDocument(null).then((jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("Get Document Revision no id", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.getDocRevNoId);
      });

      wilting.getDocumentRevision(null).then((jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("Delete Document no id", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.deleteDocNoIdRev);
      });

      wilting.deleteDocument(null, null).then((jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("Delete Document no rev", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.deleteDocNoIdRev);
      });

      wilting.deleteDocument('1', null).then((jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("Put Document no id", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.putDocNoIdBody);
      });

      jsonobject.JsonObject doc;
      wilting.putDocument(null, doc).then((jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("Put Document no data", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.putDocNoIdBody);
      });

      wilting.putDocument('1', null).then((jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("Post Document no document body", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.postDocNoBody);
      });

      wilting.postDocument(null).then((jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("Post Document String no document string", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.postDocStringNoBody);
      });

      wilting.postDocumentString(null).then((jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("Create Database no name", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.createDbNoName);
      });

      wilting.createDatabase(null).then((jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("Delete Database no name", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.deleteDbNoName);
      });

      wilting.deleteDatabase(null).then((jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("All Docs invalid limit ", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.getAllDocsLimit);
      });

      wilting.getAllDocs(limit: -1).then((jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("Generate Ids invalid amount ", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(), WiltException.header + WiltException.genIdsAmount);
      });

      wilting.generateIds(-1).then((jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("Copy document no source id", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.copyDocNoSrcId);
      });

      wilting.copyDocument(null, '1').then((jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("Copy document no destinationid", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.copyDocNoDestId);
      });

      wilting.copyDocument('1', null).then((jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("Login null user name", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      try {
        wilting.login(null, "password");
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.loginWrongParams);
      }
    });

    test("Login null password", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      try {
        wilting.login("name", null);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.loginWrongParams);
      }
    });

    test("Create Attachment no Doc Id", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.createAttNoDocId);
      });

      final String payload = 'Hello';
      wilting.createAttachment(null, 'name', 'rev', 'image/png', payload).then(
          (jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("Create Attachment no Attachment name", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.createAttNoName);
      });

      final String payload = 'Hello';
      wilting.createAttachment('id', null, 'rev', 'image/png', payload).then(
          (jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("Create Attachment no Revision", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.createAttNoRev);
      });

      final String payload = 'Hello';
      wilting.createAttachment('id', 'name', null, 'image/png', payload).then(
          (jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("Create Attachment no Content Type", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.createAttNoContentType);
      });

      final String payload = 'Hello';
      wilting.createAttachment('id', 'name', 'rev', null, payload).then(
          (jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("Create Attachment no Payload", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.createAttNoPayload);
      });

      wilting.createAttachment('id', 'name', 'rev', 'image/png', null).then(
          (jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("Update Attachment no Doc Id", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.updateAttNoDocId);
      });

      final String payload = 'Hello';
      wilting.updateAttachment(null, 'name', 'rev', 'image/png', payload).then(
          (jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("Update Attachment no Attachment name", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.updateAttNoName);
      });

      final String payload = 'Hello';
      wilting.updateAttachment('id', null, 'rev', 'image/png', payload).then(
          (jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("Update Attachment no Revision", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.updateAttNoRev);
      });

      final String payload = 'Hello';
      wilting.updateAttachment('id', 'name', null, 'image/png', payload).then(
          (jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("Update Attachment no Content Type", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.updateAttNoContentType);
      });

      final String payload = 'Hello';
      wilting.updateAttachment('id', 'name', 'rev', null, payload).then(
          (jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("Update Attachment no Payload", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.updateAttNoPayload);
      });

      wilting.updateAttachment('id', 'name', 'rev', 'image/png', null).then(
          (jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("Delete Attachment no Doc Id", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.deleteAttNoDocId);
      });

      wilting.deleteAttachment(null, 'name', 'rev').then(
          (jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("Delete Attachment no Attachment name", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.deleteAttNoName);
      });

      wilting.deleteAttachment('id', null, 'rev').then(
          (jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("Delete Attachment no Revision", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.deleteAttNoRev);
      });

      wilting.deleteAttachment('id', 'name', null).then(
          (jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("Get Attachment no Doc Id", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.getAttNoDocId);
      });

      wilting.getAttachment(null, 'name').then((jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("Get Attachment no Attachment name", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(), WiltException.header + WiltException.getAttNoName);
      });

      wilting.getAttachment('id', null).then((jsonobject.JsonObject res) {
        // nothing to do
      }, onError: (WiltException e) {
        completer(e);
      });
    });

    test("Start Notifications no Auth Credentials", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      try {
        wilting.startChangeNotification(null);
      } catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(), WiltException.header + WiltException.cnNoAuth);
      }
    });
  }, skip: false);

  /* Group 4 - Single documents and database methods */
  group("4. Single documents and database - ", () {
    /* Create our Wilt */
    final WiltServerClient wilting =
        new WiltServerClient(hostName, serverPort, scheme);

    /* Login if we are using authentication */
    if (userName != null) {
      wilting.login(userName, userPassword);
    }

    /*Group setup */
    String docId;
    String docRev;
    final String putId = 'mytestid';
    final String putId2 = 'mytestid2';
    final String putId3 = 'mytestid3';
    final String copyId = 'mycopyid';
    String returnedDocRev;

    test("Create Database not authorized", () {
      /* Create a local wilting for this test */
      final WiltServerClient localWilting =
          new WiltServerClient(hostName, serverPort, scheme);

      localWilting.login('freddy', 'freddypass');

      final completer = expectAsync1((res) {
        expect(res.method, Wilt.createDatabasee);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          expect(errorResponse.error, equals('unauthorized'));
          expect(
              errorResponse.reason, equals('Name or password is incorrect.'));
          expect(res.errorCode, equals(0));
        }
      });

      localWilting.createDatabase(databaseNameServer)
        ..then((res) {
          completer(res);
        });
    });
    /* Create a database then delete it */
    test("Delete Database", () {
      final checkCompleter = expectAsync1((res) {
        expect(res.method, Wilt.deleteDatabasee);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Delete Database check");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
        }
      });

      final completer = expectAsync1((res) {
        expect(res.method, Wilt.createDatabasee);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Create Database Failed");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
        }

        /* Now delete it */
        wilting.deleteDatabase("wiltdeleteme")
          ..then((res) {
            checkCompleter(res);
          });
      });

      wilting.createDatabase("wiltdeleteme")
        ..then((res) {
          completer(res);
        });
    });

    /* Delete the test database now we know delete is OK before we start the tests */
    test("Delete Test Database", () {
      final completer = expectAsync1((res) {
        expect(res.method, Wilt.deleteDatabasee);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Create Database Failed");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
        }
      });

      wilting.deleteDatabase(databaseNameServer)
        ..then((res) {
          completer(res);
        });
    });

    /* Create the test database */
    test("Create Test Database", () {
      final completer = expectAsync1((res) {
        expect(res.method, Wilt.createDatabasee);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Create Test Database Failed");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
        }

        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        expect(successResponse.ok, isTrue);
      });

      wilting.createDatabase(databaseNameServer)
        ..then((res) {
          completer(res);
        });
    });

    test("HEAD null URL", () {
      final completer = expectAsync1((res) {
        expect(res.method, Wilt.headd);
        try {
          expect(res.error, isTrue);
        } catch (e) {
          logMessage("WILT::Head null URL");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
        }
      });

      wilting.db = databaseNameServer;
      wilting.head(null)
        ..then((res) {
          completer(res);
        });
    });

    test("Create document(POST) and check", () {
      final checkCompleter = expectAsync1((res) {
        expect(res.method, Wilt.getDocumentt);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Create Document(POST) and check creation");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        /* Check the documents parameters */
        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        final String returnedDocId =
            WiltUserUtils.getDocumentId(successResponse);
        expect(returnedDocId, docId);
        final String returnedDocRev =
            WiltUserUtils.getDocumentRev(successResponse);
        expect(successResponse.title, equals("Created by a Post Request"));
        expect(successResponse.version, equals(1));
        expect(successResponse.author, equals("Me"));
      });

      final completer = expectAsync1((res) {
        expect(res.method, Wilt.postDocumentt);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Create Document(POST) and check");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        /* Get the documents id and re-get the document to check correctness */
        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        docId = successResponse.id;
        expect(docId, isNot(isEmpty));
        /* Now get the document and check it */
        wilting.getDocument(docId)
          ..then((res) {
            checkCompleter(res);
          });
      });

      wilting.db = databaseNameServer;
      final jsonobject.JsonObject document = new jsonobject.JsonObject();
      document.title = "Created by a Post Request";
      document.version = 1;
      document.author = "Me";
      wilting.postDocument(document)
        ..then((res) {
          completer(res);
        });
    });

    test("Create document(PUT) and check", () {
      final checkCompleter = expectAsync1((res) {
        expect(res.method, Wilt.getDocumentt);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Create Document(PUT) and check updated");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        /* Check the documents parameters */
        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        final String returnedDocId =
            WiltUserUtils.getDocumentId(successResponse);
        expect(returnedDocId, putId);
        returnedDocRev = WiltUserUtils.getDocumentRev(successResponse);
        expect(successResponse.title, equals("Created by a Put Request"));
        expect(successResponse.version, equals(2));
        expect(successResponse.author, equals("Me again"));
      });

      final completer = expectAsync1((res) {
        expect(res.method, Wilt.putDocumentt);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Test Put Document and check");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        /* Get the documents id and re-get the document to check correctness */
        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        final String putDocId = successResponse.id;
        expect(putDocId, equals(putId));
        /* Now get the document and check it */
        wilting.getDocument(putId)
          ..then((res) {
            checkCompleter(res);
          });
      });

      wilting.db = databaseNameServer;
      final jsonobject.JsonObject document = new jsonobject.JsonObject();
      document.title = "Created by a Put Request";
      document.version = 2;
      document.author = "Me again";
      wilting.putDocument(putId, document)
        ..then((res) {
          completer(res);
        });
    });

    test("Update document(PUT) and check", () {
      final checkUpdater = expectAsync1((res) {
        expect(res.method, Wilt.putDocumentt);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Update document and check updated");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        /* Check the documents parameters */
        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        final String returnedDocId = successResponse.id;
        expect(returnedDocId, equals(putId));
        final String returnedDocRev = successResponse.rev;
        expect(returnedDocRev, isNot(equals(docRev)));
        docRev = returnedDocRev;
      });

      final checkCompleter = expectAsync1((res) {
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Update document and check created");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        /* Check the documents parameters */
        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        final returnedDocId = WiltUserUtils.getDocumentId(successResponse);
        expect(returnedDocId, putId);
        final String returnedDocRev =
            WiltUserUtils.getDocumentRev(successResponse);
        docRev = returnedDocRev;
        expect(successResponse.title,
            equals("Created by a Put Request for checking"));
        expect(successResponse.version, equals(3));
        expect(successResponse.author, equals("Me also"));
        /* Now alter the document using putDocument */
        final jsonobject.JsonObject document = new jsonobject.JsonObject();
        document.title = "Created by a Put Request for updating ";
        document.version = 4;
        document.author = "Me also and again";
        final String docString =
            WiltUserUtils.addDocumentRev(document, returnedDocRev);
        wilting.putDocumentString(putId, docString)
          ..then((res) {
            checkUpdater(res);
          });
      });

      final completer = expectAsync1((res) {
        expect(res.method, Wilt.putDocumentt);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Update document and check");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        /* Get the documents id and re-get the document to check correctness */
        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        final String putDocId = successResponse.id;
        expect(putDocId, equals(putId));
        /* Now get the document and check it */
        wilting.getDocument(putId)
          ..then((res) {
            checkCompleter(res);
          });
      });

      wilting.db = databaseNameServer;
      final jsonobject.JsonObject document = new jsonobject.JsonObject();
      document.title = "Created by a Put Request for checking";
      document.version = 3;
      document.author = "Me also";
      wilting.putDocument(putId, document, returnedDocRev)
        ..then((res) {
          completer(res);
        });
    });

    test("Get document revision and check ", () {
      wilting.db = databaseNameServer;
      wilting.getDocumentRevision(putId)
        ..then((rev) {
          expect(rev == docRev, true);
        });
    });

    test("Delete document and check ", () {
      final checkCompleter = expectAsync1((res) {
        expect(res.method, Wilt.deleteDocumentt);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Delete document and check deletion");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        /* Check the document has been deleted */
        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        final String putDocId = successResponse.id;
        expect(putDocId, equals(putId3));
      });

      final completer = expectAsync1((res) {
        expect(res.method, Wilt.putDocumentt);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Delete document and check");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        /* Get the documents id and re-get the document to check correctness */
        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        final String putDocId = successResponse.id;
        expect(putDocId, equals(putId3));
        final String returnedDocRev = successResponse.rev;
        /* Now delete the document and check it */
        wilting.deleteDocument(putId3, returnedDocRev)
          ..then((res) {
            checkCompleter(res);
          });
      });

      wilting.db = databaseNameServer;
      final jsonobject.JsonObject document = new jsonobject.JsonObject();
      document.title = "Created by a Put Request for deleting";
      document.version = 1;
      document.author = "Its me again";
      wilting.putDocument(putId3, document)
        ..then((res) {
          completer(res);
        });
    });

    test("Delete document preserve and check ", () {
      final checkCompleter = expectAsync1((res) {
        expect(res.method, Wilt.putDocumentt);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Delete document preserve and check deletion");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        /* Check the document has been deleted */
        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        final String putDocId = successResponse.id;
        expect(putDocId, equals(putId2));
      });

      final completer = expectAsync1((res) {
        expect(res.method, Wilt.putDocumentt);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Delete document preserve and check");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        /* Get the documents id and re-get the document to check correctness */
        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        final String putDocId = successResponse.id;
        expect(putDocId, equals(putId2));
        final String returnedDocRev = successResponse.rev;
        /* Now delete the document and check it */
        wilting.deleteDocument(putId2, returnedDocRev, true)
          ..then((res) {
            checkCompleter(res);
          });
      });

      wilting.db = databaseNameServer;
      final jsonobject.JsonObject document = new jsonobject.JsonObject();
      document.title = "Created by a Put Request for preserve deleting";
      document.version = 1;
      document.author = "Its me again";
      wilting.putDocument(putId2, document)
        ..then((res) {
          completer(res);
        });
    });

    test("Copy document", () {
      final completer = expectAsync1((res) {
        expect(res.method, Wilt.copyDocumentt);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Copy document");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        /* Check the copied document */
        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        final String copyDocId = successResponse.id;
        expect(copyDocId, equals(copyId));
      });

      wilting.db = databaseNameServer;
      wilting.copyDocument(putId, copyId)
        ..then((res) {
          completer(res);
        });
    });

    /* Raw HTTP Request */
    test("Raw HTTP Request", () {
      final completer = expectAsync1((res) {
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Raw HTTP Request failed");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        final String returnedDocId =
            WiltUserUtils.getDocumentId(successResponse);
        expect(returnedDocId, putId);
      });

      final String url = "/$databaseNameServer/$putId";
      wilting.httpRequest(url)
        ..then((res) {
          completer(res);
        });
    });
  }, skip: false);

  /* Group 5 - Bulk documents */
  group("5. Bulk Documents - ", () {
    test("User Utils  - Various", () {
      final String id = "myId";
      final String rev = "1-765frd";
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
      final List<jsonobject.JsonObject> jList = [record, record2];
      final String bulk = WiltUserUtils.createBulkInsertStringJo(jList);
      expect(bulk, isNotNull);
      expect(bulk,
          '{"docs":[ {"name":"Steve","tag":"MyTag","_id":"myId","_rev":"1-765frd"},{"name":"newName","tag":"2-uy6543","_id":"myId","_rev":"1-765frd"}]}');
    });

    /* Create our Wilt */
    final WiltServerClient wilting =
        new WiltServerClient(hostName, serverPort, scheme);

    /* Login if we are using authentication */
    if (userName != null) {
      wilting.login(userName, userPassword);
    }

    /* Setup */
    final String putId = 'mytestid';
    final String putId2 = 'mytestid2';
    final String copyId = 'mycopyid';

    test("Get All Docs  - Include docs", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((res) {
        expect(res.method, Wilt.getAllDocss);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Get All Docs  - Include docs");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        expect(successResponse.total_rows, equals(3));
        expect(successResponse.rows[1].id, equals(copyId));
        expect(successResponse.rows[2].id, equals(putId));
      });
      /* Login if we are using authentication */
      if (userName != null) {
        wilting.login(userName, userPassword);
      }
      wilting.db = databaseNameServer;
      wilting.getAllDocs(includeDocs: true)
        ..then((res) {
          completer(res);
        });
    });

    test("Get All Docs  - limit", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((res) {
        expect(res.method, Wilt.getAllDocss);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Get All Docs  - limit");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        expect(successResponse.total_rows, equals(3));
        expect(successResponse.rows[0].id, isNot(equals(putId)));
        expect(successResponse.rows[0].id, isNot(equals(putId2)));
        int count = 0;
        for (final x in successResponse.rows) {
          count++;
        }
        expect(count, equals(1));
      });
      /* Login if we are using authentication */
      if (userName != null) {
        wilting.login(userName, userPassword);
      }
      wilting.db = databaseNameServer;
      wilting.getAllDocs(limit: 1)
        ..then((res) {
          completer(res);
        });
    });

    test("Get All Docs  - start key", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((res) {
        expect(res.method, Wilt.getAllDocss);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Get All Docs  - start key");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        expect(successResponse.total_rows, equals(3));
        expect(successResponse.rows[0].id, equals(putId));
        int count = 0;
        for (final x in successResponse.rows) {
          count++;
        }
        expect(count, equals(1));
      });
      /* Login if we are using authentication */
      if (userName != null) {
        wilting.login(userName, userPassword);
      }
      wilting.db = databaseNameServer;
      wilting.getAllDocs(startKey: putId)
        ..then((res) {
          completer(res);
        });
    });

    test("Get All Docs  - end key", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((res) {
        expect(res.method, Wilt.getAllDocss);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Test Get All Docs  - end key");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        expect(successResponse.total_rows, equals(3));
        expect(successResponse.rows[1].id, equals(copyId));
        int count = 0;
        for (final x in successResponse.rows) {
          count++;
        }
        expect(count, equals(3));
      });
      /* Login if we are using authentication */
      if (userName != null) {
        wilting.login(userName, userPassword);
      }
      wilting.db = databaseNameServer;
      wilting.getAllDocs(endKey: putId2)
        ..then((res) {
          completer(res);
        });
    });

    test("Get All Docs - key list", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((res) {
        expect(res.method, Wilt.getAllDocss);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Test Get All Docs  - key list");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        expect(successResponse.total_rows, equals(3));
        expect(successResponse.rows[0].id, equals(putId));
        expect(successResponse.rows[1].key, equals(putId2));
        int count = 0;
        for (final x in successResponse.rows) {
          count++;
        }
        expect(count, equals(2));
      });
      /* Login if we are using authentication */
      if (userName != null) {
        wilting.login(userName, userPassword);
      }
      wilting.db = databaseNameServer;
      final List keyList = new List<String>();
      keyList.add(putId);
      keyList.add(putId2);
      wilting.getAllDocs(keys: keyList)
        ..then((res) {
          completer(res);
        });
    });

    test("Get All Docs  - descending", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((res) {
        expect(res.method, Wilt.getAllDocss);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Get All Docs  - descending");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        expect(successResponse.total_rows, equals(3));
        expect(successResponse.rows[1].id, equals(putId));
        expect(successResponse.rows[0].key, equals(putId2));
        int count = 0;
        for (final x in successResponse.rows) {
          count++;
        }
        expect(count, equals(2));
      });
      /* Login if we are using authentication */
      if (userName != null) {
        wilting.login(userName, userPassword);
      }
      wilting.db = databaseNameServer;
      final List keyList = new List<String>();
      keyList.add(putId);
      keyList.add(putId2);
      wilting.getAllDocs(keys: keyList, descending: true)
        ..then((res) {
          completer(res);
        });
    });

    test("Bulk Insert Auto Keys", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((res) {
        expect(res.method, Wilt.bulkk);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Bulk Insert Auto Keys");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        expect(successResponse[0].ok, isTrue);
        expect(successResponse[1].ok, isTrue);
        expect(successResponse[2].ok, isTrue);
      });
      /* Login if we are using authentication */
      if (userName != null) {
        wilting.login(userName, userPassword);
      }
      wilting.db = databaseNameServer;
      final List docList = new List<jsonobject.JsonObject>();
      final jsonobject.JsonObject document1 = new jsonobject.JsonObject();
      document1.title = "Document 1";
      document1.version = 1;
      document1.attribute = "Doc 1 attribute";
      docList.add(document1);
      final jsonobject.JsonObject document2 = new jsonobject.JsonObject();
      document2.title = "Document 2";
      document2.version = 2;
      document2.attribute = "Doc 2 attribute";
      docList.add(document2);
      final jsonobject.JsonObject document3 = new jsonobject.JsonObject();
      document3.title = "Document 3";
      document3.version = 3;
      document3.attribute = "Doc 3 attribute";
      docList.add(document3);

      wilting.bulk(docList)
        ..then((res) {
          completer(res);
        });
    });

    test("Bulk Insert Supplied Keys", () {
      final WiltServerClient wilting =
          new WiltServerClient(hostName, serverPort, scheme);

      final completer = expectAsync1((res) {
        expect(res.method, Wilt.bulkStringg);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Bulk Insert Supplied Keys");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        expect(successResponse[0].id, equals("MyBulkId1"));
        expect(successResponse[1].id, equals("MyBulkId2"));
        expect(successResponse[2].id, equals("MyBulkId3"));
      });

      /* Login if we are using authentication */
      if (userName != null) {
        wilting.login(userName, userPassword);
      }
      wilting.db = databaseNameServer;

      final jsonobject.JsonObject document1 = new jsonobject.JsonObject();
      document1.title = "Document 1";
      document1.version = 1;
      document1.attribute = "Doc 1 attribute";
      final String doc1 = WiltUserUtils.addDocumentId(document1, "MyBulkId1");
      final jsonobject.JsonObject document2 = new jsonobject.JsonObject();
      document2.title = "Document 2";
      document2.version = 2;
      document2.attribute = "Doc 2 attribute";
      final String doc2 = WiltUserUtils.addDocumentId(document2, "MyBulkId2");
      final jsonobject.JsonObject document3 = new jsonobject.JsonObject();
      document3.title = "Document 3";
      document3.version = 3;
      document3.attribute = "Doc 3 attribute";
      final String doc3 = WiltUserUtils.addDocumentId(document3, "MyBulkId3");
      final List docList = new List<String>();
      docList.add(doc1);
      docList.add(doc2);
      docList.add(doc3);
      final String docs = WiltUserUtils.createBulkInsertString(docList);
      wilting.bulkString(docs)
        ..then((res) {
          completer(res);
        });
    });
  }, skip: false);

  /* Group 6 - Information tests */
  group("Information/Utilty Tests - ", () {
    /* Create our Wilt */
    final WiltServerClient wilting =
        new WiltServerClient(hostName, serverPort, scheme);

    /* Login if we are using authentication */
    if (userName != null) {
      wilting.login(userName, userPassword);
    }

    test("Get Session Information", () {
      final completer = expectAsync1((res) {
        expect(res.method, Wilt.getSessionn);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Get Session Failed");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        expect(successResponse.ok, isTrue);
      });

      wilting.getSession()
        ..then((res) {
          completer(res);
        });
    });

    test("Get Stats Information", () {
      final completer = expectAsync1((res) {
        expect(res.method, Wilt.getStatss);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Get Stats Failed");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        expect(successResponse.couchdb, isNotNull);
      });

      wilting.getStats()
        ..then((res) {
          completer(res);
        });
    });

    test("Get Database Information - default", () {
      final completer = expectAsync1((res) {
        expect(res.method, Wilt.databaseInfo);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Get Database Information - default");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        expect(successResponse.db_name, equals(databaseNameServer));
      });

      wilting.db = databaseNameServer;
      wilting.getDatabaseInfo()
        ..then((res) {
          completer(res);
        });
    });

    test("Get Database Information - specified", () {
      final completer = expectAsync1((res) {
        expect(res.method, Wilt.databaseInfo);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Get Database Information - specified");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        expect(successResponse.db_name, equals(databaseNameServer));
      });

      wilting.getDatabaseInfo(databaseNameServer)
        ..then((res) {
          completer(res);
        });
    });

    test("Get All DB's", () {
      final completer = expectAsync1((res) {
        expect(res.method, Wilt.getAllDbss);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Get All Db's Failed");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        expect(successResponse.contains(databaseNameServer), isTrue);
      });

      wilting.getAllDbs()
        ..then((res) {
          completer(res);
        });
    });

    test("Generate Ids", () {
      final completer = expectAsync1((res) {
        expect(res.method, Wilt.generateIdss);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Generate Ids");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        expect(successResponse.uuids.length, equals(10));
      });

      wilting.generateIds(10)
        ..then((res) {
          completer(res);
        });
    });
  }, skip: false);

  /* Group 7 - Attachment tests */
  group("Attachment Tests - ", () {
    /* Create our Wilt */
    final WiltServerClient wilting =
        new WiltServerClient(hostName, serverPort, scheme);

    /* Login if we are using authentication */
    if (userName != null) {
      wilting.login(userName, userPassword);
    }

    /* Globals for the group */
    String testDocRev;
    final String pngImage =
        'iVBORw0KGgoAAAANSUhEUgAAABwAAAASCAMAAAB/2U7WAAAABl' +
            'BMVEUAAAD///+l2Z/dAAAASUlEQVR4XqWQUQoAIAxC2/0vXZDr' +
            'EX4IJTRkb7lobNUStXsB0jIXIAMSsQnWlsV+wULF4Avk9fLq2r' +
            '8a5HSE35Q3eO2XP1A1wQkZSgETvDtKdQAAAABJRU5ErkJggg==';

    final String pngImageUpdate =
        'iVBORw0KGgoAAAANSUhEUgAAABwAAAASCAMAAAB/2U7WAAAABl' +
            'BMVEUAAAD///+l2Z/dAAAASUlEQVR4XqWQUQoAIAxC2/0vXZDr' +
            'EX4IJTRkb7lobNUStXsB0jIXIAMSsQnWlsV+wULF4Avk9fLq2r' +
            '8a5HSE35Q3eO2XP1A1wQkZSgETvDtKdQAAAABJRU5ErkJggg!!';

    test("Create document(PUT) for attachment tests and check", () {
      final checkCompleter = expectAsync1((res) {
        expect(res.method, Wilt.getDocumentt);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage(
              "WILT::Create Document(PUT) for attachment tests and check updated");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
        }

        /* Check the documents parameters */
        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        final String returnedDocId =
            WiltUserUtils.getDocumentId(successResponse);
        expect(returnedDocId, 'attachmentTestDoc');
        testDocRev = WiltUserUtils.getDocumentRev(successResponse);
        expect(successResponse.title,
            equals("Created by a Put Request for attachment testing"));
        expect(successResponse.version, equals(1));
        expect(successResponse.author, equals("SJH"));
      });

      final completer = expectAsync1((res) {
        expect(res.method, Wilt.putDocumentt);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Test Put Document for attachment tests and check");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
        }

        /* Get the documents id and re-get the document to check correctness */
        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        final String putDocId = successResponse.id;
        expect(putDocId, equals('attachmentTestDoc'));
        /* Now get the document and check it */
        wilting.getDocument('attachmentTestDoc')
          ..then((res) {
            checkCompleter(res);
          });
      });

      wilting.db = databaseNameServer;
      final jsonobject.JsonObject document = new jsonobject.JsonObject();
      document.title = "Created by a Put Request for attachment testing";
      document.version = 1;
      document.author = "SJH";
      wilting.putDocument('attachmentTestDoc', document)
        ..then((res) {
          completer(res);
        });
    });

    test("Create Attachment", () {
      final completer = expectAsync1((res) {
        expect(res.method, Wilt.createAttachmentt);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Create Attachment Failed");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        expect(successResponse.ok, isTrue);
        testDocRev = WiltUserUtils.getDocumentRev(successResponse);
      });

      wilting.db = databaseNameServer;
      wilting.createAttachment('attachmentTestDoc', 'attachmentName',
          testDocRev, 'image/png', pngImage)
        ..then((res) {
          completer(res);
        });
    });

    test("Get Create Attachment", () {
      final revisionCompleter = expectAsync1((res) {
        expect(res.method, Wilt.getDocumentt);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Get Create Attachment Get Document Revision");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
        }

        /* Check the documents parameters */
        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        final String returnedDocId =
            WiltUserUtils.getDocumentId(successResponse);
        expect(returnedDocId, 'attachmentTestDoc');
        testDocRev = WiltUserUtils.getDocumentRev(successResponse);
        expect(successResponse.title,
            equals("Created by a Put Request for attachment testing"));
        expect(successResponse.version, equals(1));
        expect(successResponse.author, equals("SJH"));
        final List attachments = WiltUserUtils.getAttachments(successResponse);
        expect(attachments[0].name, 'attachmentName');
        expect(attachments[0].data.content_type, 'image/png; charset=utf-8');
        expect(attachments[0].data.length, anything);
        final List bytes =
            CryptoUtils.base64StringToBytes(attachments[0].data.data);
        expect(bytes, pngImage.codeUnits);
      });

      final completer = expectAsync1((res) {
        expect(res.method, Wilt.getAttachmentt);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Get Create Attachment Failed");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        expect(successResponse.ok, isTrue);
        final String payload = res.responseText;
        expect(payload, equals(pngImage));
        final String contentType = successResponse.contentType;
        expect(contentType, equals('image/png; charset=utf-8'));
        /* Now get the document to get the new revision along
         * with its attachment data
         */
        wilting.getDocument('attachmentTestDoc', null, true)
          ..then((res) {
            revisionCompleter(res);
          });
      });

      wilting.db = databaseNameServer;
      wilting.getAttachment('attachmentTestDoc', 'attachmentName')
        ..then((res) {
          completer(res);
        });
    });

    test("Update Attachment", () {
      final completer = expectAsync1((res) {
        expect(res.method, Wilt.updateAttachmentt);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Update Attachment Failed");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        expect(successResponse.ok, isTrue);
      });

      wilting.db = databaseNameServer;
      wilting.updateAttachment('attachmentTestDoc', 'attachmentName',
          testDocRev, 'image/png', pngImageUpdate)
        ..then((res) {
          completer(res);
        });
    });

    test("Get Update Attachment", () {
      final revisionCompleter = expectAsync1((res) {
        expect(res.method, Wilt.getDocumentt);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Get Update Attachment Get Document Revision");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
        }

        /* Check the documents parameters */
        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        final String returnedDocId =
            WiltUserUtils.getDocumentId(successResponse);
        expect(returnedDocId, 'attachmentTestDoc');
        testDocRev = WiltUserUtils.getDocumentRev(successResponse);
        expect(successResponse.title,
            equals("Created by a Put Request for attachment testing"));
        expect(successResponse.version, equals(1));
        expect(successResponse.author, equals("SJH"));
      });

      final completer = expectAsync1((res) {
        expect(res.method, Wilt.getAttachmentt);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Get Update Attachment Failed");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        expect(successResponse.ok, isTrue);
        testDocRev = WiltUserUtils.getDocumentRev(successResponse);
        final String payload = res.responseText;
        expect(payload, equals(pngImageUpdate));
        final String contentType = successResponse.contentType;
        expect(contentType, equals('image/png; charset=utf-8'));
        /* Now get the document to get the new revision  */
        wilting.getDocument('attachmentTestDoc')
          ..then((res) {
            revisionCompleter(res);
          });
      });

      wilting.db = databaseNameServer;
      wilting.getAttachment('attachmentTestDoc', 'attachmentName')
        ..then((res) {
          completer(res);
        });
    });

    test("Create Attachment With New Document", () {
      final completer = expectAsync1((res) {
        expect(res.method, Wilt.createAttachmentt);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Create Attachment Failed");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        expect(successResponse.ok, isTrue);
      });

      wilting.db = databaseNameServer;
      wilting.createAttachment('anotherAttachmentTestDoc', 'attachmentName', '',
          'image/png', pngImage)
        ..then((res) {
          completer(res);
        });
    });

    test("Create Attachment Invalid Revision", () {
      final completer = expectAsync1((res) {
        expect(res.method, Wilt.createAttachmentt);
        expect(res.error, isTrue);
        final int statusCode = res.errorCode;
        expect(statusCode, equals(0));
      });

      wilting.db = databaseNameServer;
      wilting.createAttachment('attachmentTestDoc', 'anotherAttachmentName',
          '1-bb48c078f0fac47234e774a7a51b86ac', 'image/png', pngImage)
        ..then((res) {
          completer(res);
        });
    });

    test("Delete Attachment", () {
      final completer = expectAsync1((res) {
        expect(res.method, Wilt.deleteAttachmentt);
        try {
          expect(res.error, isFalse);
        } catch (e) {
          logMessage("WILT::Delete Attachment Failed");
          final jsonobject.JsonObject errorResponse = res.jsonCouchResponse;
          final String errorText = errorResponse.error;
          logMessage("WILT::Error is $errorText");
          final String reasonText = errorResponse.reason;
          logMessage("WILT::Reason is $reasonText");
          final int statusCode = res.errorCode;
          logMessage("WILT::Status code is $statusCode");
          return;
        }

        final jsonobject.JsonObject successResponse = res.jsonCouchResponse;
        expect(successResponse.ok, isTrue);
      });

      wilting.db = databaseNameServer;
      wilting.deleteAttachment(
          'attachmentTestDoc', 'attachmentName', testDocRev)
        ..then((res) {
          completer(res);
        });
    });
  }, skip: false);

  /* Group 8 - Change Notifications */
  group("Change Notification Tests - ", () {
    /* Create our Wilt */
    final WiltServerClient wilting =
        new WiltServerClient(hostName, serverPort, scheme);

    /* Login for change notification */
    if (userName != null) {
      wilting.login(userName, userPassword);
    }

    test("Start Change Notification", () {
      wilting.db = databaseNameServer;
      void wrapper() {
        wilting.startChangeNotification();
      }

      expect(wrapper, returnsNormally);
    });

    test("Check Change Notifications", () {
      int count = 0;

      final completer = expectAsync0(() {
        wilting.stopChangeNotification();
        expect(count, 12);
      });

      wilting.changeNotification.listen((e) {
        count++;
        if (e.docId == 'mytestid2')
          expect(
              (e.type == WiltChangeNotificationEvent.updatee) ||
                  (e.type == WiltChangeNotificationEvent.deletee),
              true);
        if (e.docId == 'mytestid3')
          expect(e.type, WiltChangeNotificationEvent.deletee);
        if (e.docId == 'anotherAttachmentTestDoc') completer();
      });
    });

    test("Start Change Notification With Docs and Attachments", () {
      wilting.db = databaseNameServer;
      final WiltChangeNotificationParameters parameters =
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

      final completer = expectAsync0(() {
        expect(count, 12);
      });

      wilting.changeNotification.listen((e) {
        count++;
        if (e.docId == 'mytestid2') {
          if (e.type == WiltChangeNotificationEvent.updatee) {
            final jsonobject.JsonObject document = e.document;
            expect(document.title, "Created by a Put Request for updating ");
            expect(document.version, 4);
            expect(document.author, "Me also and again");
          } else {
            expect(e.type == WiltChangeNotificationEvent.deletee, true);
          }
        }
        if (e.docId == 'mytestid3')
          expect(e.type, WiltChangeNotificationEvent.deletee);
        if (e.docId == 'anotherAttachmentTestDoc') {
          final List attachments = WiltUserUtils.getAttachments(e.document);
          expect(attachments[0].name, 'attachmentName');
          expect(attachments[0].data.content_type, "image/png; charset=utf-8");
          completer();
        }
      });
    });

    test("Notification Pause", () {
      int count = 0;

      final completer = expectAsync0(() {
        expect(count, 3);
        wilting.pauseChangeNotifications();
      });

      wilting.changeNotification.listen((e) {
        count++;
        expect(e.type, WiltChangeNotificationEvent.lastSequence);
        if (count == 3) completer();
      });
    });

    test("Check Notification Pause", () {
      final completer = expectAsync0(() {
        expect(wilting.changeNotificationsPaused, true);
      });

      completer();
    });

    test("Notification Restart", () {
      int count = 0;

      final completer = expectAsync0(() {
        expect(wilting.changeNotificationsPaused, false);
        expect(count, 3);
        wilting.stopChangeNotification();
      });

      wilting.restartChangeNotifications();
      wilting.changeNotification.listen((e) {
        count++;
        expect(e.type, WiltChangeNotificationEvent.lastSequence);
        if (count == 3) completer();
      });
    });
  }, skip: false);
}
