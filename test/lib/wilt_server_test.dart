/*
 * Package : WiltServerClient
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 04/06/2013
 * Copyright :  S.Hamblett@OSCF
 */

library wilt_server_test;

@TestOn('vm')
import 'package:wilt/wilt.dart';
import 'package:wilt/wilt_server_client.dart';
import 'package:test/test.dart';
import 'wilt_test_common.dart';
import 'wilt_test_config.dart';

void main() {
  // WiltServerClient constructor tests
  var groupNum = 0;
  group('${groupNum++}. Constructor Tests - ', () {
    var testNum = 0;
    test('${testNum++}. No hostname', () {
      try {
        final wilting = WiltServerClient(null, serverPort, scheme);
        wilting.toString();
      } on Exception catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.badConstParams);
      }
    });

    test('${testNum++}. No port', () {
      try {
        final wilting = WiltServerClient(hostName, null, scheme);
        wilting.toString();
      } on Exception catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.badConstParams);
      }
    });

    test('${testNum++}. No Scheme', () {
      try {
        final wilting = WiltServerClient(hostName, serverPort, null);
        wilting.toString();
      } on Exception catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.badConstParams);
      }
    });

    test('${testNum++}. No HTTP Adapter', () {
      try {
        final wilting = WiltServerClient(hostName, serverPort, scheme, null);
        wilting.toString();
      } on Exception catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(e.toString(),
            WiltException.header + WiltException.badConstNoAdapter);
      }
    });
  }, skip: false);

  /// Run the common API tests

  // Test client
  final wilting = WiltServerClient(hostName, serverPort, scheme);

  // Create a test client for database creation/deletion testing
  final dbTestWilting = WiltServerClient(hostName, serverPort, scheme);

  void logger(String message) {
    print(message);
  }

  WiltTestCommon.run(wilting, dbTestWilting, databaseNameServer, logger);
}
