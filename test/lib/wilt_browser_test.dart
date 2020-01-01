/*
 * Package : WiltBrowserClient
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 04/06/2013
 * Copyright :  S.Hamblett@OSCF
 */

library wilt_test_browser;

@TestOn('browser')
import 'dart:html';
import 'package:wilt/wilt_browser_client.dart';
import 'package:test/test.dart';
import 'wilt_test_common.dart';
import 'wilt_test_config.dart';

// ignore_for_file: omit_local_variable_types
// ignore_for_file: unnecessary_final
// ignore_for_file: cascade_invocations
// ignore_for_file: avoid_print
// ignore_for_file: avoid_annotating_with_dynamic

void main() {
  /// Info for test run only, constructor tests are done in the
  /// server test suite.
  int groupNum = 1;
  print('${groupNum++}. Constructor Tests - performed as part of server tests');

  /// Run the common API tests, other common tests such as construction
  /// etc. are run in the server test suite.

  //  Test client
  final WiltBrowserClient wilting = WiltBrowserClient(hostName, port, scheme);

  // Create a test client for database creation/deletion testing
  final WiltBrowserClient dbTestWilting =
      WiltBrowserClient(hostName, port, scheme);

  void logger(String message) {
    window.console.log(message);
  }

  WiltTestCommon.run(wilting, dbTestWilting, databaseNameBrowser, logger);
}
