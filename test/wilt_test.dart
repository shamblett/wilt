/*
 * Package : WiltServerClient
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 12/12/2017
 * Copyright :  S.Hamblett
 */

import 'dart:convert';
import 'package:wilt/wilt.dart';
import 'package:json_object_lite/json_object_lite.dart' as jsonobject;
import 'package:test/test.dart';
import 'wilt_test_config.dart';

@TestOn('vm && browser')
void main() {
  // WiltServerClient constructor tests
  var groupNum = 0;

  // Test client
  final wilting = Wilt(hostName, port: serverPort, useSSL: useSSL);

  // Create a test client for database creation/deletion testing
  final dbTestWilting = Wilt(hostName, port: serverPort, useSSL: useSSL);

  void logMessage(String message) {
    print(message);
  }

  void logExceptionWithResponse(String s, dynamic res) {
    logExceptionWithResponse(s, res);
    final dynamic errorResponse = res.jsonCouchResponse;
    final errorText = errorResponse.error;
    logMessage('WILT::Error is $errorText');
    final reasonText = errorResponse.reason;
    logMessage('WILT::Reason is $reasonText');
    final int? statusCode = res.errorCode;
    logMessage('WILT::Status code is $statusCode');
  }

  group('${groupNum++}. Constructor Tests - ', () {
    var testNum = 0;
    test('${testNum++}. No hostname', () {
      try {
        final wilting = Wilt(null, port: serverPort, useSSL: useSSL);
        wilting.toString();
      } on Exception catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.badConstParams);
      }
    });
  }, skip: false);

  // Basic methods parameter validation
  group('${groupNum++}. Basic Methods Parameter Validation - ', () {
    var testNum = 1;
    test('${testNum++}. No Database Set HEAD', () {
      final dynamic completer = expectAsync1((WiltException e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.noDatabaseSpecified);
      });
      wilting.head(null).then((dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. No Database Set GET', () {
      final dynamic completer = expectAsync1((WiltException e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.noDatabaseSpecified);
      });
      wilting.get(null).then((dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. No Database Set POST', () {
      final dynamic completer = expectAsync1((dynamic e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.noDatabaseSpecified);
      });
      wilting.post(null, '1').then((dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. No Database Set PUT', () {
      final dynamic completer = expectAsync1((dynamic e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.noDatabaseSpecified);
      });
      wilting.put(null, '1').then((dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. No Database Set DELETE', () {
      final dynamic completer = expectAsync1((dynamic e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.noDatabaseSpecified);
      });
      wilting.delete(null).then((dynamic res) {
        // nothing to do
      }, onError: completer);
    });
  }, skip: false);

  // Document/Database methods parameter validation
  group('${groupNum++}. Document/Database Parameter Validation - ', () {
    var testNum = 1;
    test('${testNum++}. Get Document no id', () {
      final dynamic completer = expectAsync1((dynamic e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(), WiltException.header + WiltException.getDocNoId);
      });
      wilting.getDocument(null).then((dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. Get Document Revision no id', () {
      final dynamic completer = expectAsync1((dynamic e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.getDocRevNoId);
      });
      wilting.getDocumentRevision(null).then((dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. Delete Document no id', () {
      final dynamic completer = expectAsync1((dynamic e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.deleteDocNoIdRev);
      });
      wilting.deleteDocument(null, null).then((dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. Delete Document no rev', () {
      final dynamic completer = expectAsync1((dynamic e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.deleteDocNoIdRev);
      });
      wilting.deleteDocument('1', null).then((dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. Put Document no id', () {
      final dynamic completer = expectAsync1((dynamic e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.putDocNoIdBody);
      });
      dynamic doc;
      wilting.putDocument(null, doc).then((dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. Put Document no data', () {
      final dynamic completer = expectAsync1((dynamic e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.putDocNoIdBody);
      });
      wilting.putDocument('1', null).then((dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. Post Document no document body', () {
      final dynamic completer = expectAsync1((dynamic e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.postDocNoBody);
      });
      wilting.postDocument(null).then((dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. Post Document String no document string', () {
      final dynamic completer = expectAsync1((dynamic e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.postDocStringNoBody);
      });
      wilting.postDocumentString(null).then((dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. Create Database no name', () {
      final dynamic completer = expectAsync1((dynamic e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.createDbNoName);
      });
      wilting.createDatabase(null).then((dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. Delete Database no name', () {
      final dynamic completer = expectAsync1((dynamic e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.deleteDbNoName);
      });
      wilting.deleteDatabase(null).then((dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. All Docs invalid limit ', () {
      final dynamic completer = expectAsync1((dynamic e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.getAllDocsLimit);
      });
      wilting.getAllDocs(limit: -1).then((dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. Generate Ids invalid amount ', () {
      final dynamic completer = expectAsync1((dynamic e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(), WiltException.header + WiltException.genIdsAmount);
      });
      wilting.generateIds(-1).then((dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. Copy document no source id', () {
      final dynamic completer = expectAsync1((dynamic e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.copyDocNoSrcId);
      });
      wilting.copyDocument(null, '1').then((dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. Copy document no destinationid', () {
      final dynamic completer = expectAsync1((dynamic e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.copyDocNoDestId);
      });
      wilting.copyDocument('1', null).then((dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. Login null user name', () {
      try {
        wilting.login(null, 'password');
      } on Exception catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.loginWrongParams);
      }
    });

    test('${testNum++}. Login null password', () {
      try {
        wilting.login('name', null);
      } on Exception catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.loginWrongParams);
      }
    });

    test('${testNum++}. Create Attachment no Doc Id', () {
      final dynamic completer = expectAsync1((dynamic e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.createAttNoDocId);
      });
      const payload = 'Hello';
      wilting.createAttachment(null, 'name', 'rev', 'image/png', payload).then(
          (dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. Create Attachment no Attachment name', () {
      final dynamic completer = expectAsync1((dynamic e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.createAttNoName);
      });
      const payload = 'Hello';
      wilting.createAttachment('id', null, 'rev', 'image/png', payload).then(
          (dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. Create Attachment no Revision', () {
      final dynamic completer = expectAsync1((dynamic e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.createAttNoRev);
      });
      const payload = 'Hello';
      wilting.createAttachment('id', 'name', null, 'image/png', payload).then(
          (dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. Create Attachment no Content Type', () {
      final dynamic completer = expectAsync1((dynamic e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.createAttNoContentType);
      });
      const payload = 'Hello';
      wilting.createAttachment('id', 'name', 'rev', null, payload).then(
          (dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. Create Attachment no Payload', () {
      final dynamic completer = expectAsync1((dynamic e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.createAttNoPayload);
      });
      wilting.createAttachment('id', 'name', 'rev', 'image/png', null).then(
          (dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. Update Attachment no Doc Id', () {
      final dynamic completer = expectAsync1((dynamic e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.updateAttNoDocId);
      });
      const payload = 'Hello';
      wilting.updateAttachment(null, 'name', 'rev', 'image/png', payload).then(
          (dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. Update Attachment no Attachment name', () {
      final dynamic completer = expectAsync1((dynamic e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.updateAttNoName);
      });
      const payload = 'Hello';
      wilting.updateAttachment('id', null, 'rev', 'image/png', payload).then(
          (dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. Update Attachment no Revision', () {
      final dynamic completer = expectAsync1((dynamic e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.updateAttNoRev);
      });
      const payload = 'Hello';
      wilting.updateAttachment('id', 'name', null, 'image/png', payload).then(
          (dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. Update Attachment no Content Type', () {
      final dynamic completer = expectAsync1((dynamic e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.updateAttNoContentType);
      });
      const payload = 'Hello';
      wilting.updateAttachment('id', 'name', 'rev', null, payload).then(
          (dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. Update Attachment no Payload', () {
      final dynamic completer = expectAsync1((dynamic e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.updateAttNoPayload);
      });
      wilting.updateAttachment('id', 'name', 'rev', 'image/png', null).then(
          (dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. Delete Attachment no Doc Id', () {
      final dynamic completer = expectAsync1((dynamic e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.deleteAttNoDocId);
      });
      wilting.deleteAttachment(null, 'name', 'rev').then((dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. Delete Attachment no Attachment name', () {
      final dynamic completer = expectAsync1((dynamic e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.deleteAttNoName);
      });
      wilting.deleteAttachment('id', null, 'rev').then((dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. Delete Attachment no Revision', () {
      final dynamic completer = expectAsync1((dynamic e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.deleteAttNoRev);
      });
      wilting.deleteAttachment('id', 'name', null).then((dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. Get Attachment no Doc Id', () {
      final dynamic completer = expectAsync1((dynamic e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.getAttNoDocId);
      });
      wilting.getAttachment(null, 'name').then((dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. Get Attachment no Attachment name', () {
      final dynamic completer = expectAsync1((dynamic e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(), WiltException.header + WiltException.getAttNoName);
      });
      wilting.getAttachment('id', null).then((dynamic res) {
        // nothing to do
      }, onError: completer);
    });

    test('${testNum++}. Start Notifications no Auth Credentials', () {
      try {
        wilting.startChangeNotification(null);
      } on Exception catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(), WiltException.header + WiltException.cnNoAuth);
      }
    });
  }, skip: false);

  // Single documents and database methods
  group('${groupNum++}. Single documents and database - ', () {
    var testNum = 0;
    // Login if we are using authentication
    wilting.login(userName, userPassword);

    // Group setup
    String? docId;
    String? docRev;
    const putId = 'mytestid';
    const putId2 = 'mytestid2';
    const putId3 = 'mytestid3';
    const copyId = 'mycopyid';
    String? returnedDocRev;

    test('${testNum++}. Create Database not authorized', () {
      dbTestWilting.login('freddy', 'freddypass');
      final dynamic completer = expectAsync1((dynamic res) {
        expect(res.method, Wilt.createDatabasee);
        try {
          expect(res.error, isTrue);
        } on Exception {
          final dynamic errorResponse = res.jsonCouchResponse;
          expect(errorResponse.error, equals('unauthorized'));
          expect(
              errorResponse.reason, equals('Name or password is incorrect.'));
          expect(res.errorCode, equals(401));
        }
      });
      dbTestWilting.createDatabase(databaseName).then(completer);
    });
    // Create a database then delete it
    test('${testNum++}. Delete Database', () {
      final dynamic checkCompleter = expectAsync1((dynamic res) {
        expect(res.method, Wilt.deleteDatabasee);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse('WILT::Delete Database check', res);
        }
      });

      final dynamic completer = expectAsync1((dynamic res) {
        expect(res.method, Wilt.createDatabasee);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse('WILT::Create Database Failed', res);
        }

        // Now delete it
        wilting.deleteDatabase('wiltdeleteme').then(checkCompleter);
      });

      wilting.createDatabase('wiltdeleteme').then(completer);
    });

    // Delete the test database now we know delete is OK before we
    // start the tests.
    test('${testNum++}. Delete Test Database', () {
      final dynamic completer = expectAsync1((dynamic res) {
        expect(res.method, Wilt.deleteDatabasee);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse('WILT::Create Database Failed', res);
        }
      });

      wilting.deleteDatabase(databaseName).then(completer);
    });

    // Create the test database
    test('${testNum++}. Create Test Database', () {
      final dynamic completer = expectAsync1((dynamic res) {
        expect(res.method, Wilt.createDatabasee);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse('WILT::Create Test Database Failed', res);
        }

        final dynamic successResponse = res.jsonCouchResponse;
        expect(successResponse.ok, isTrue);
      });

      wilting.createDatabase(databaseName).then(completer);
    });

    test('HEAD null URL', () {
      final dynamic completer = expectAsync1((dynamic res) {
        expect(res.method, Wilt.headd);
        try {
          expect(res.error, isTrue);
        } on Exception {
          logExceptionWithResponse('WILT::Head null URL', res);
        }
      });

      wilting.db = databaseName;
      wilting.head(null).then(completer);
    });

    test('${testNum++}. Create document(POST) and check', () {
      final dynamic checkCompleter = expectAsync1((dynamic res) {
        expect(res.method, Wilt.getDocumentt);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse(
              'WILT::Create Document(POST) and check creation', res);
          return;
        }

        // Check the documents parameters
        final dynamic successResponse = res.jsonCouchResponse;
        final returnedDocId = WiltUserUtils.getDocumentId(successResponse);
        expect(returnedDocId, docId);
        expect(successResponse.title, equals('Created by a Post Request'));
        expect(successResponse.version, equals(1));
        expect(successResponse.author, equals('Me'));
      });

      final dynamic completer = expectAsync1((dynamic res) {
        expect(res.method, Wilt.postDocumentt);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse(
              'WILT::Create Document(POST) and check', res);
          return;
        }

        // Get the documents id and re-get the document to check correctness
        final dynamic successResponse = res.jsonCouchResponse;
        docId = successResponse.id;
        expect(docId, isNot(isEmpty));
        // Now get the document and check it
        wilting.getDocument(docId).then(checkCompleter);
      });

      wilting.db = databaseName;
      final dynamic document = jsonobject.JsonObjectLite<dynamic>();
      document.title = 'Created by a Post Request';
      document.version = 1;
      document.author = 'Me';
      wilting.postDocument(document).then(completer);
    });

    test('${testNum++}. Create document(PUT) and check', () {
      final dynamic checkCompleter = expectAsync1((dynamic res) {
        expect(res.method, Wilt.getDocumentt);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse(
              'WILT::Create Document(PUT) and check updated', res);
          return;
        }

        // Check the documents parameters
        final dynamic successResponse = res.jsonCouchResponse;
        final returnedDocId = WiltUserUtils.getDocumentId(successResponse);
        expect(returnedDocId, putId);
        returnedDocRev = WiltUserUtils.getDocumentRev(successResponse);
        expect(successResponse.title, equals('Created by a Put Request'));
        expect(successResponse.version, equals(2));
        expect(successResponse.author, equals('Me again'));
      });

      final dynamic completer = expectAsync1((dynamic res) {
        expect(res.method, Wilt.putDocumentt);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse('WILT::Test Put Document and check', res);
          return;
        }

        // Get the documents id and re-get the document to check correctness
        final dynamic successResponse = res.jsonCouchResponse;
        final putDocId = successResponse.id;
        expect(putDocId, equals(putId));
        // Now get the document and check it
        wilting.getDocument(putId).then(checkCompleter);
      });

      wilting.db = databaseName;
      final dynamic document = jsonobject.JsonObjectLite<dynamic>();
      document.title = 'Created by a Put Request';
      document.version = 2;
      document.author = 'Me again';
      wilting.putDocument(putId, document).then(completer);
    });

    test('${testNum++}. Update document(PUT) and check', () {
      final dynamic checkUpdater = expectAsync1((dynamic res) {
        expect(res.method, Wilt.putDocumentt);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse(
              'WILT::Update document and check updated', res);
          return;
        }

        // Check the documents parameters
        final dynamic successResponse = res.jsonCouchResponse;
        final returnedDocId = successResponse.id;
        expect(returnedDocId, equals(putId));
        final returnedDocRev = successResponse.rev;
        expect(returnedDocRev, isNot(equals(docRev)));
        docRev = returnedDocRev;
      });

      final dynamic checkCompleter = expectAsync1((dynamic res) {
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse(
              'WILT::Update document and check created', res);
          return;
        }

        // Check the documents parameters
        final dynamic successResponse = res.jsonCouchResponse;
        final returnedDocId = WiltUserUtils.getDocumentId(successResponse);
        expect(returnedDocId, putId);
        final returnedDocRev = WiltUserUtils.getDocumentRev(successResponse);
        docRev = returnedDocRev;
        expect(successResponse.title,
            equals('Created by a Put Request for checking'));
        expect(successResponse.version, equals(3));
        expect(successResponse.author, equals('Me also'));
        // Now alter the document using putDocument
        final dynamic document = jsonobject.JsonObjectLite<dynamic>();
        document.title = 'Created by a Put Request for updating ';
        document.version = 4;
        document.author = 'Me also and again';
        final docString =
            WiltUserUtils.addDocumentRev(document, returnedDocRev);
        wilting.putDocumentString(putId, docString).then(checkUpdater);
      });

      final dynamic completer = expectAsync1((dynamic res) {
        expect(res.method, Wilt.putDocumentt);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse('WILT::Update document and check', res);
          return;
        }

        // Get the documents id and re-get the document to check correctness
        final dynamic successResponse = res.jsonCouchResponse;
        final putDocId = successResponse.id;
        expect(putDocId, equals(putId));
        // Now get the document and check it
        wilting.getDocument(putId).then(checkCompleter);
      });

      wilting.db = databaseName;
      final dynamic document = jsonobject.JsonObjectLite<dynamic>();
      document.title = 'Created by a Put Request for checking';
      document.version = 3;
      document.author = 'Me also';
      wilting.putDocument(putId, document, returnedDocRev).then(completer);
    });

    test('${testNum++}. Get document revision and check ', () {
      wilting.db = databaseName;
      wilting.getDocumentRevision(putId).then((dynamic rev) {
        if (rev != null) {
          expect(rev == docRev, true);
        }
      });
    });

    test('${testNum++}. Delete document and check ', () {
      final dynamic checkCompleter = expectAsync1((dynamic res) {
        expect(res.method, Wilt.deleteDocumentt);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse(
              'WILT::Delete document and check deletion', res);
          return;
        }

        // Check the document has been deleted
        final dynamic successResponse = res.jsonCouchResponse;
        final putDocId = successResponse.id;
        expect(putDocId, equals(putId3));
      });

      final dynamic completer = expectAsync1((dynamic res) {
        expect(res.method, Wilt.putDocumentt);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse('WILT::Delete document and check', res);
          return;
        }

        // Get the documents id and re-get the document to check correctness
        final dynamic successResponse = res.jsonCouchResponse;
        final putDocId = successResponse.id;
        expect(putDocId, equals(putId3));
        final returnedDocRev = successResponse.rev;
        // Now delete the document and check it
        wilting.deleteDocument(putId3, returnedDocRev).then(checkCompleter);
      });

      wilting.db = databaseName;
      final dynamic document = jsonobject.JsonObjectLite<dynamic>();
      document.title = 'Created by a Put Request for deleting';
      document.version = 1;
      document.author = 'Its me again';
      wilting.putDocument(putId3, document).then(completer);
    });

    test('${testNum++}. Delete document preserve and check ', () {
      final dynamic checkCompleter = expectAsync1((dynamic res) {
        expect(res.method, Wilt.putDocumentt);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse(
              'WILT::Delete document preserve and check deletion', res);
          return;
        }

        // Check the document has been deleted
        final dynamic successResponse = res.jsonCouchResponse;
        final putDocId = successResponse.id;
        expect(putDocId, equals(putId2));
      });

      final dynamic completer = expectAsync1((dynamic res) {
        expect(res.method, Wilt.putDocumentt);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse(
              'WILT::Delete document preserve and check', res);
          return;
        }

        // Get the documents id and re-get the document to check correctness
        final dynamic successResponse = res.jsonCouchResponse;
        final putDocId = successResponse.id;
        expect(putDocId, equals(putId2));
        final returnedDocRev = successResponse.rev;
        // Now delete the document and check it
        wilting
            .deleteDocument(putId2, returnedDocRev, true)
            .then(checkCompleter);
      });

      wilting.db = databaseName;
      final dynamic document = jsonobject.JsonObjectLite<dynamic>();
      document.title = 'Created by a Put Request for preserve deleting';
      document.version = 1;
      document.author = 'Its me again';
      wilting.putDocument(putId2, document).then(completer);
    });

    test('${testNum++}. Copy document', () {
      final dynamic completer = expectAsync1((dynamic res) {
        expect(res.method, Wilt.copyDocumentt);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse('WILT::Copy document', res);
          return;
        }

        // Check the copied document
        final dynamic successResponse = res.jsonCouchResponse;
        final copyDocId = successResponse.id;
        expect(copyDocId, equals(copyId));
      });

      wilting.db = databaseName;
      wilting.copyDocument(putId, copyId).then(completer);
    });

    // Raw HTTP Request
    test('${testNum++}. Raw HTTP Request', () {
      final dynamic completer = expectAsync1((dynamic res) {
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse('WILT::Raw HTTP Request failed', res);
          return;
        }

        final dynamic successResponse = res.jsonCouchResponse;
        final returnedDocId = WiltUserUtils.getDocumentId(successResponse);
        expect(returnedDocId, putId);
      });

      final url = '/$databaseName/$putId';
      wilting.httpRequest(url).then(completer);
    });
  }, skip: false);

  // Bulk documents
  group('${groupNum++}. Bulk Documents - ', () {
    var testNum = 0;
    test('${testNum++}. User Utils  - Various', () {
      const id = 'myId';
      const rev = '1-765frd';
      dynamic record = jsonobject.JsonObjectLite<dynamic>();
      record.name = 'Steve';
      record.tag = 'MyTag';
      dynamic record2 = record;

      record = WiltUserUtils.addDocumentIdJo(record, id);
      var tmp = record.toString();
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

      record2.name = 'newName';
      record2.tag = '2-uy6543';
      final jList = <jsonobject.JsonObjectLite<dynamic>>[record, record2];
      final bulk = WiltUserUtils.createBulkInsertStringJo(jList);
      expect(bulk, isNotNull);
      expect(
          bulk,
          '{"docs":[{"name":"Steve","tag":"MyTag","_id":"myId",'
          '"_rev":"1-765frd"},{"name":"newName","tag":"2-uy6543",'
          '"_id":"myId","_rev":"1-765frd"}]}');
    });

    // Login if we are using authentication
    wilting.login(userName, userPassword);

    // Setup
    const putId = 'mytestid';
    const putId2 = 'mytestid2';
    const copyId = 'mycopyid';

    test('${testNum++}. Get All Docs  - Include docs', () {
      final dynamic completer = expectAsync1((dynamic res) {
        expect(res.method, Wilt.getAllDocss);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse('WILT::Get All Docs  - Include docs', res);
          return;
        }

        final dynamic successResponse = res.jsonCouchResponse;
        expect(successResponse.total_rows, equals(3));
        expect(successResponse.rows[1].id, equals(copyId));
        expect(successResponse.rows[2].id, equals(putId));
      });
      // Login if we are using authentication
      wilting.login(userName, userPassword);
      wilting.db = databaseName;
      wilting.getAllDocs(includeDocs: true).then(completer);
    });

    test('${testNum++}. Get All Docs  - limit', () {
      final dynamic completer = expectAsync1((dynamic res) {
        expect(res.method, Wilt.getAllDocss);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse('WILT::Get All Docs  - limit', res);
          return;
        }

        final dynamic successResponse = res.jsonCouchResponse;
        expect(successResponse.total_rows, equals(3));
        expect(successResponse.rows[0].id, isNot(equals(putId)));
        expect(successResponse.rows[0].id, isNot(equals(putId2)));
        final int? count = successResponse.rows.length;
        expect(count, equals(1));
      });
      // Login if we are using authentication
      wilting.login(userName, userPassword);

      wilting.db = databaseName;
      wilting.getAllDocs(limit: 1).then(completer);
    });

    test('${testNum++}. Get All Docs  - start key', () {
      final dynamic completer = expectAsync1((dynamic res) {
        expect(res.method, Wilt.getAllDocss);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse('WILT::Get All Docs  - start key', res);
          return;
        }

        final dynamic successResponse = res.jsonCouchResponse;
        expect(successResponse.total_rows, equals(3));
        expect(successResponse.rows[0].id, equals(putId));
        final int? count = successResponse.rows.length;
        expect(count, equals(1));
      });
      // Login if we are using authentication
      wilting.login(userName, userPassword);

      wilting.db = databaseName;
      wilting.getAllDocs(startKey: putId).then(completer);
    });

    test('${testNum++}. Get All Docs  - end key', () {
      final dynamic completer = expectAsync1((dynamic res) {
        expect(res.method, Wilt.getAllDocss);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse('WILT::Test Get All Docs  - end key', res);
          return;
        }

        final dynamic successResponse = res.jsonCouchResponse;
        expect(successResponse.total_rows, equals(3));
        expect(successResponse.rows[1].id, equals(copyId));
        final int? count = successResponse.rows.length;
        expect(count, equals(3));
      });
      // Login if we are using authentication
      wilting.login(userName, userPassword);

      wilting.db = databaseName;
      wilting.getAllDocs(endKey: putId2).then(completer);
    });

    test('${testNum++}. Get All Docs - key list', () {
      final dynamic completer = expectAsync1((dynamic res) {
        expect(res.method, Wilt.getAllDocss);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse('WILT::Test Get All Docs  - key list', res);
          return;
        }

        final dynamic successResponse = res.jsonCouchResponse;
        expect(successResponse.total_rows, equals(3));
        expect(successResponse.rows[0].id, equals(putId));
        expect(successResponse.rows[1].key, equals(putId2));
        final int? count = successResponse.rows.length;
        expect(count, equals(2));
      });
      // Login if we are using authentication
      wilting.login(userName, userPassword);

      wilting.db = databaseName;
      final keyList = <String>[];
      keyList.add(putId);
      keyList.add(putId2);
      wilting.getAllDocs(keys: keyList).then(completer);
    });

    test('${testNum++}. Get All Docs  - descending', () {
      final dynamic completer = expectAsync1((dynamic res) {
        expect(res.method, Wilt.getAllDocss);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse('WILT::Get All Docs  - descending', res);
          return;
        }

        final dynamic successResponse = res.jsonCouchResponse;
        expect(successResponse.total_rows, equals(3));
        expect(successResponse.rows[1].id, equals(putId));
        expect(successResponse.rows[0].key, equals(putId2));
        final int? count = successResponse.rows.length;
        expect(count, equals(2));
      });
      // Login if we are using authentication
      wilting.login(userName, userPassword);

      wilting.db = databaseName;
      final keyList = <String>[];
      keyList.add(putId);
      keyList.add(putId2);
      wilting.getAllDocs(keys: keyList, descending: true).then(completer);
    });

    test('${testNum++}. Bulk Insert Auto Keys', () {
      final dynamic completer = expectAsync1((dynamic res) {
        expect(res.method, Wilt.bulkk);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse('WILT::Bulk Insert Auto Keys', res);
          return;
        }

        final dynamic successResponse = res.jsonCouchResponse;
        expect(successResponse[0].ok, isTrue);
        expect(successResponse[1].ok, isTrue);
        expect(successResponse[2].ok, isTrue);
      });
      // Login if we are using authentication
      wilting.login(userName, userPassword);
      wilting.db = databaseName;
      final docList = <jsonobject.JsonObjectLite<dynamic>>[];
      final dynamic document1 = jsonobject.JsonObjectLite<dynamic>();
      document1.title = 'Document 1';
      document1.version = 1;
      document1.attribute = 'Doc 1 attribute';
      docList.add(document1);
      final dynamic document2 = jsonobject.JsonObjectLite<dynamic>();
      document2.title = 'Document 2';
      document2.version = 2;
      document2.attribute = 'Doc 2 attribute';
      docList.add(document2);
      final dynamic document3 = jsonobject.JsonObjectLite<dynamic>();
      document3.title = 'Document 3';
      document3.version = 3;
      document3.attribute = 'Doc 3 attribute';
      docList.add(document3);

      wilting.bulk(docList).then(completer);
    });

    test('${testNum++}. Bulk Insert Supplied Keys', () {
      final dynamic completer = expectAsync1((dynamic res) {
        expect(res.method, Wilt.bulkStringg);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse('WILT::Bulk Insert Supplied Keys', res);
          return;
        }

        final dynamic successResponse = res.jsonCouchResponse;
        expect(successResponse[0].id, equals('MyBulkId1'));
        expect(successResponse[1].id, equals('MyBulkId2'));
        expect(successResponse[2].id, equals('MyBulkId3'));
      });

      // Login if we are using authentication
      wilting.login(userName, userPassword);

      wilting.db = databaseName;

      final dynamic document1 = jsonobject.JsonObjectLite<dynamic>();
      document1.title = 'Document 1';
      document1.version = 1;
      document1.attribute = 'Doc 1 attribute';
      final doc1 = WiltUserUtils.addDocumentId(document1, 'MyBulkId1');
      final dynamic document2 = jsonobject.JsonObjectLite<dynamic>();
      document2.title = 'Document 2';
      document2.version = 2;
      document2.attribute = 'Doc 2 attribute';
      final doc2 = WiltUserUtils.addDocumentId(document2, 'MyBulkId2');
      final dynamic document3 = jsonobject.JsonObjectLite<dynamic>();
      document3.title = 'Document 3';
      document3.version = 3;
      document3.attribute = 'Doc 3 attribute';
      final doc3 = WiltUserUtils.addDocumentId(document3, 'MyBulkId3');
      final docList = <String>[];
      docList.add(doc1);
      docList.add(doc2);
      docList.add(doc3);
      final docs = WiltUserUtils.createBulkInsertString(docList);
      wilting.bulkString(docs).then(completer);
    });
  }, skip: false);

  // Information tests
  group('${groupNum++}. Information/Utilty Tests - ', () {
    var testNum = 0;
    // Login if we are using authentication
    wilting.login(userName, userPassword);

    test('${testNum++}. Get Session Information', () {
      final dynamic completer = expectAsync1((dynamic res) {
        expect(res.method, Wilt.getSessionn);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse('WILT::Get Session Failed', res);
          return;
        }

        final dynamic successResponse = res.jsonCouchResponse;
        expect(successResponse.ok, isTrue);
      });

      wilting.getSession().then(completer);
    });

    test('${testNum++}. Get Database Information - default', () {
      final dynamic completer = expectAsync1((dynamic res) {
        expect(res.method, Wilt.databaseInfo);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse(
              'WILT::Get Database Information - default', res);
          return;
        }

        final dynamic successResponse = res.jsonCouchResponse;
        expect(successResponse.db_name, equals(databaseName));
      });

      wilting.db = databaseName;
      wilting.getDatabaseInfo().then(completer);
    });

    test('${testNum++}. Get Database Information - specified', () {
      final dynamic completer = expectAsync1((dynamic res) {
        expect(res.method, Wilt.databaseInfo);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse(
              'WILT::Get Database Information - specified', res);
          return;
        }

        final dynamic successResponse = res.jsonCouchResponse;
        expect(successResponse.db_name, equals(databaseName));
      });

      wilting.getDatabaseInfo(databaseName).then(completer);
    });

    test("${testNum++}. Get All DB's", () {
      final dynamic completer = expectAsync1((dynamic res) {
        expect(res.method, Wilt.getAllDbss);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logMessage("WILT::Get All Db's Failed");
          final dynamic errorResponse = res.jsonCouchResponse;
          final errorText = errorResponse.error;
          logMessage('WILT::Error is $errorText');
          final reasonText = errorResponse.reason;
          logMessage('WILT::Reason is $reasonText');
          final int? statusCode = res.errorCode;
          logMessage('WILT::Status code is $statusCode');
          return;
        }

        final dynamic successResponse = res.jsonCouchResponse;
        expect(successResponse.contains(databaseName), isTrue);
      });

      wilting.getAllDbs().then(completer);
    });

    test('${testNum++}. Generate Ids', () {
      final dynamic completer = expectAsync1((dynamic res) {
        expect(res.method, Wilt.generateIdss);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse('WILT::Generate Ids', res);
          return;
        }

        final dynamic successResponse = res.jsonCouchResponse;
        expect(successResponse.uuids.length, equals(10));
      });

      wilting.generateIds(10).then(completer);
    });
  }, skip: false);

  // Attachment tests
  group('${groupNum++}. Attachment Tests - ', () {
    var testNum = 0;
    // Login if we are using authentication
    wilting.login(userName, userPassword);

    // Globals for the group
    String? testDocRev;
    const pngImage =
        'iVBORw0KGgoAAAANSUhEUgAAABwAAAASCAMAAAB/2U7WAAAABlBMVEUAAAD///+l2Z/dAAAASUlEQVR4XqWQUQoAIAxC2/0vXZDrEX4IJTRkb7lobNUStXsB0jIXIAMSsQnWlsV+wULF4Avk9fLq2r8a5HSE35Q3eO2XP1A1wQkZSgETvDtKdQAAAABJRU5ErkJggg==';

    const pngImageUpdate =
        'iVBORw0KGgoAAAANSUhEUgAAABwAAAASCAMAAAB/2U7WAAAABlBMVEUAAAD///+l2Z/dAAAASUlEQVR4XqWQUQoAIAxC2/0vXZDrEX4IJTRkb7lobNUStXsB0jIXIAMSsQnWlsV+wULF4Avk9fLq2r8a5HSE35Q3eO2XP1A1wQkZSgETvDtKdQAAAABJRU5ErkJggg!!';

    test('${testNum++}. Create document(PUT) for attachment tests and check',
        () {
      final dynamic checkCompleter = expectAsync1((dynamic res) {
        expect(res.method, Wilt.getDocumentt);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logMessage('WILT::Create Document(PUT) for attachment tests and '
              'check updated');
          final dynamic errorResponse = res.jsonCouchResponse;
          final errorText = errorResponse.error;
          logMessage('WILT::Error is $errorText');
          final reasonText = errorResponse.reason;
          logMessage('WILT::Reason is $reasonText');
          final int? statusCode = res.errorCode;
          logMessage('WILT::Status code is $statusCode');
        }

        // Check the documents parameters
        final dynamic successResponse = res.jsonCouchResponse;
        final returnedDocId = WiltUserUtils.getDocumentId(successResponse);
        expect(returnedDocId, 'attachmentTestDoc');
        testDocRev = WiltUserUtils.getDocumentRev(successResponse);
        expect(successResponse.title,
            equals('Created by a Put Request for attachment testing'));
        expect(successResponse.version, equals(1));
        expect(successResponse.author, equals('SJH'));
      });

      final dynamic completer = expectAsync1((dynamic res) {
        expect(res.method, Wilt.putDocumentt);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logMessage('WILT::Test Put Document for attachment tests and check');
          final dynamic errorResponse = res.jsonCouchResponse;
          final errorText = errorResponse.error;
          logMessage('WILT::Error is $errorText');
          final reasonText = errorResponse.reason;
          logMessage('WILT::Reason is $reasonText');
          final int? statusCode = res.errorCode;
          logMessage('WILT::Status code is $statusCode');
        }

        // Get the documents id and re-get the document to check correctness
        final dynamic successResponse = res.jsonCouchResponse;
        final putDocId = successResponse.id;
        expect(putDocId, equals('attachmentTestDoc'));
        // Now get the document and check it
        wilting.getDocument('attachmentTestDoc').then(checkCompleter);
      });

      wilting.db = databaseName;
      final dynamic document = jsonobject.JsonObjectLite<dynamic>();
      document.title = 'Created by a Put Request for attachment testing';
      document.version = 1;
      document.author = 'SJH';
      wilting.putDocument('attachmentTestDoc', document).then(completer);
    });

    test('${testNum++}. Create Attachment', () {
      final dynamic completer = expectAsync1((dynamic res) {
        expect(res.method, Wilt.createAttachmentt);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse('WILT::Create Attachment Failed', res);
          return;
        }

        final dynamic successResponse = res.jsonCouchResponse;
        expect(successResponse.ok, isTrue);
        testDocRev = WiltUserUtils.getDocumentRev(successResponse);
      });

      wilting.db = databaseName;
      wilting
          .createAttachment('attachmentTestDoc', 'attachmentName', testDocRev,
              'image/png', pngImage)
          .then(completer);
    });

    test('${testNum++}. Get Create Attachment', () {
      final dynamic revisionCompleter = expectAsync1((dynamic res) {
        expect(res.method, Wilt.getDocumentt);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse(
              'WILT::Get Create Attachment Get Document Revision', res);
        }

        // Check the documents parameters
        final dynamic successResponse = res.jsonCouchResponse;
        final returnedDocId = WiltUserUtils.getDocumentId(successResponse);
        expect(returnedDocId, 'attachmentTestDoc');
        testDocRev = WiltUserUtils.getDocumentRev(successResponse);
        expect(successResponse.title,
            equals('Created by a Put Request for attachment testing'));
        expect(successResponse.version, equals(1));
        expect(successResponse.author, equals('SJH'));
        final List<dynamic> attachments =
            WiltUserUtils.getAttachments(successResponse);
        expect(attachments[0].name, 'attachmentName');
        expect(attachments[0].data.content_type, 'image/png; charset=utf-8');
        expect(attachments[0].data.length, anything);
        final List<int> bytes =
            const Base64Decoder().convert(attachments[0].data.data);
        expect(bytes, pngImage.codeUnits);
      });

      final dynamic completer = expectAsync1((dynamic res) {
        expect(res.method, Wilt.getAttachmentt);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse('WILT::Get Create Attachment Failed', res);
          return;
        }

        final dynamic successResponse = res.jsonCouchResponse;
        expect(successResponse.ok, isTrue);
        final payload = res.responseText;
        expect(payload, equals(pngImage));
        final contentType = successResponse.contentType;
        expect(contentType, equals('image/png; charset=utf-8'));
        // Now get the document to get the revision along
        // with its attachment data

        wilting
            .getDocument('attachmentTestDoc', null, true)
            .then(revisionCompleter);
      });

      wilting.db = databaseName;
      wilting
          .getAttachment('attachmentTestDoc', 'attachmentName')
          .then(completer);
    });

    test('${testNum++}. Update Attachment', () {
      final dynamic completer = expectAsync1((dynamic res) {
        expect(res.method, Wilt.updateAttachmentt);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse('WILT::Update Attachment Failed', res);
          return;
        }

        final dynamic successResponse = res.jsonCouchResponse;
        expect(successResponse.ok, isTrue);
      });

      wilting.db = databaseName;
      wilting
          .updateAttachment('attachmentTestDoc', 'attachmentName', testDocRev,
              'image/png', pngImageUpdate)
          .then(completer);
    });

    test('${testNum++}. Get Update Attachment', () {
      final dynamic revisionCompleter = expectAsync1((dynamic res) {
        expect(res.method, Wilt.getDocumentt);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse(
              'WILT::Get Update Attachment Get Document Revision', res);
        }

        // Check the documents parameters
        final dynamic successResponse = res.jsonCouchResponse;
        final returnedDocId = WiltUserUtils.getDocumentId(successResponse);
        expect(returnedDocId, 'attachmentTestDoc');
        testDocRev = WiltUserUtils.getDocumentRev(successResponse);
        expect(successResponse.title,
            equals('Created by a Put Request for attachment testing'));
        expect(successResponse.version, equals(1));
        expect(successResponse.author, equals('SJH'));
      });

      final dynamic completer = expectAsync1((dynamic res) {
        expect(res.method, Wilt.getAttachmentt);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse('WILT::Get Update Attachment Failed', res);
          return;
        }

        final dynamic successResponse = res.jsonCouchResponse;
        expect(successResponse.ok, isTrue);
        testDocRev = WiltUserUtils.getDocumentRev(successResponse);
        final payload = res.responseText;
        expect(payload, equals(pngImageUpdate));
        final contentType = successResponse.contentType;
        expect(contentType, equals('image/png; charset=utf-8'));
        // Now get the document to get the revision
        wilting.getDocument('attachmentTestDoc').then(revisionCompleter);
      });

      wilting.db = databaseName;
      wilting
          .getAttachment('attachmentTestDoc', 'attachmentName')
          .then(completer);
    });

    test('${testNum++}. Create Attachment With Document', () {
      final dynamic completer = expectAsync1((dynamic res) {
        expect(res.method, Wilt.createAttachmentt);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse('WILT::Create Attachment Failed', res);
          return;
        }

        final dynamic successResponse = res.jsonCouchResponse;
        expect(successResponse.ok, isTrue);
      });

      wilting.db = databaseName;
      wilting
          .createAttachment('anotherAttachmentTestDoc', 'attachmentName', '',
              'image/png', pngImage)
          .then(completer);
    });

    test('${testNum++}. Create Attachment Invalid Revision', () {
      final dynamic completer = expectAsync1((dynamic res) {
        expect(res.method, Wilt.createAttachmentt);
        expect(res.error, isTrue);
        final int? statusCode = res.errorCode;
        expect(statusCode, anyOf(0, 409));
      });

      wilting.db = databaseName;
      wilting
          .createAttachment('attachmentTestDoc', 'anotherAttachmentName',
              '1-bb48c078f0fac47234e774a7a51b86ac', 'image/png', pngImage)
          .then(completer);
    });

    test('${testNum++}. Delete Attachment', () {
      final dynamic completer = expectAsync1((dynamic res) {
        expect(res.method, Wilt.deleteAttachmentt);
        try {
          expect(res.error, isFalse);
        } on Exception {
          logExceptionWithResponse('WILT::Delete Attachment Failed', res);
          return;
        }

        final dynamic successResponse = res.jsonCouchResponse;
        expect(successResponse.ok, isTrue);
      });

      wilting.db = databaseName;
      wilting
          .deleteAttachment('attachmentTestDoc', 'attachmentName', testDocRev)
          .then(completer);
    });
  }, skip: false);

  // Change Notifications
  group('${groupNum++}. Change Notification Tests - ', () {
    var testNum = 0;
    // Login for change notification
    wilting.login(userName, userPassword);

    test('${testNum++}. Start Change Notification', () {
      wilting.db = databaseName;
      void wrapper() {
        wilting.startChangeNotification();
      }

      expect(wrapper, returnsNormally);
    });

    test('${testNum++}. Check Change Notifications', () {
      final dynamic completer = expectAsync0(wilting.stopChangeNotification);

      wilting.changeNotification.listen((dynamic e) {
        if (e.docId == 'mytestid2') {
          expect(
              (e.type == WiltChangeNotificationEvent.updatee) ||
                  (e.type == WiltChangeNotificationEvent.deletee),
              true);
        }
        if (e.docId == 'mytestid3') {
          expect(e.type, WiltChangeNotificationEvent.deletee);
        }
        if (e.docId == 'anotherAttachmentTestDoc') {
          completer();
        }
      });
    });

    test('${testNum++}. Start Change Notification With Docs and Attachments',
        () {
      wilting.db = databaseName;
      final parameters = WiltChangeNotificationParameters();
      parameters.includeDocs = true;
      parameters.includeAttachments = true;
      void wrapper() {
        wilting.startChangeNotification(parameters);
      }

      expect(wrapper, returnsNormally);
    });

    test('${testNum++}. Check Change Notifications With Docs', () {
      final dynamic completer = expectAsync0(() {});

      wilting.changeNotification.listen((dynamic e) {
        if (e.docId == 'mytestid2') {
          if (e.type == WiltChangeNotificationEvent.updatee) {
            final dynamic document = e.document;
            expect(document.title, 'Created by a Put Request for updating ');
            expect(document.version, 4);
            expect(document.author, 'Me also and again');
          } else {
            expect(e.type == WiltChangeNotificationEvent.deletee, true);
          }
        }
        if (e.docId == 'mytestid3') {
          expect(e.type, WiltChangeNotificationEvent.deletee);
        }
        if (e.docId == 'anotherAttachmentTestDoc') {
          final List<dynamic> attachments =
              WiltUserUtils.getAttachments(e.document);
          expect(attachments[0].name, 'attachmentName');
          expect(attachments[0].data.content_type, 'image/png; charset=utf-8');
          completer();
        }
      });
    });

    test('${testNum++}. Notification Pause', () {
      var count = 0;

      final dynamic completer = expectAsync0(() {
        expect(count, 3);
        wilting.pauseChangeNotifications();
      });

      wilting.changeNotification.listen((dynamic e) {
        count++;
        expect(e.type, WiltChangeNotificationEvent.lastSequence);
        if (count == 3) {
          completer();
        }
      });
    });

    test('${testNum++}. Check Notification Pause', () {
      final dynamic completer = expectAsync0(() {
        expect(wilting.changeNotificationsPaused, true);
      });

      completer();
    });

    test('${testNum++}. Notification Restart', () {
      var count = 0;

      final dynamic completer = expectAsync0(() {
        expect(wilting.changeNotificationsPaused, false);
        expect(count, 3);
        wilting.stopChangeNotification();
      });

      wilting.restartChangeNotifications();
      wilting.changeNotification.listen((dynamic e) {
        count++;
        expect(e.type, WiltChangeNotificationEvent.lastSequence);
        if (count == 3) {
          completer();
        }
      });
    });
  }, skip: false);
}
