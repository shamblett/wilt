/*
 * Package : WiltServerClient
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 04/06/2013
 * Copyright :  S.Hamblett@OSCF
 */

library wilt_server_test;

@TestOn("vm")
import 'package:wilt/wilt.dart';
import 'package:wilt/wilt_server_client.dart';
import 'wilt_test_common.dart';
import 'package:test/test.dart';
import 'wilt_test_config.dart';

void main() {

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

  /// Run the common API tests

  /* Test client */
  final WiltServerClient wilting =
  new WiltServerClient(hostName, serverPort, scheme);

  /* Create a test client for database creation/deletion testing */
  final WiltServerClient dbTestWilting =
  new WiltServerClient(hostName, serverPort, scheme);

  WiltTestCommon.run(wilting, dbTestWilting, databaseNameServer);
}
