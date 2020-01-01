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

// ignore_for_file: omit_local_variable_types
// ignore_for_file: unnecessary_final
// ignore_for_file: cascade_invocations
// ignore_for_file: avoid_print
// ignore_for_file: avoid_annotating_with_dynamic

void main() {
  // WiltServerClient constructor tests
  int groupNum = 0;
  group('${groupNum++}. Constructor Tests - ', () {
    int testNum = 0;
    test('${testNum++}. No hostname', () {
      try {
        final WiltServerClient wilting =
            WiltServerClient(null, serverPort, scheme);
        wilting.toString();
      } on Exception catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.badConstParams);
      }
    });

    test('${testNum++}. No port', () {
      try {
        final WiltServerClient wilting =
            WiltServerClient(hostName, null, scheme);
        wilting.toString();
      } on Exception catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.badConstParams);
      }
    });

    test('${testNum++}. No Scheme', () {
      try {
        final WiltServerClient wilting =
            WiltServerClient(hostName, serverPort, null);
        wilting.toString();
      } on Exception catch (e) {
        expect(e.runtimeType.toString(), 'WiltException');
        expect(
            e.toString(), WiltException.header + WiltException.badConstParams);
      }
    });

    test('${testNum++}. No HTTP Adapter', () {
      try {
        final WiltServerClient wilting =
            WiltServerClient(hostName, serverPort, scheme, null);
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
  final WiltServerClient wilting =
      WiltServerClient(hostName, serverPort, scheme);

  // Create a test client for database creation/deletion testing
  final WiltServerClient dbTestWilting =
      WiltServerClient(hostName, serverPort, scheme);

  void logger(String message) {
    print(message);
  }

  WiltTestCommon.run(wilting, dbTestWilting, databaseNameServer, logger);
}
