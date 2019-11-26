/*
 * Package : WiltBrowserClient
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 04/06/2013
 * Copyright :  S.Hamblett@OSCF
 *
 */

library wilt_browser_client;

import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;

import 'package:json_object_lite/json_object_lite.dart' as jsonobject;
import 'wilt.dart';

part 'src/httpAdapters/wilt_browser_http_adapter.dart';

/// The Wilt browser client.
/// An instance of Wilt specialised for use in the browser
class WiltBrowserClient extends Wilt {
  /// Construction
  WiltBrowserClient(String host, String port, String scheme,
      [Object clientCompletion])
      : super(host, port, scheme, browserHttpAdapter, clientCompletion);

  /// The HTTP adapter
  static WiltBrowserHTTPAdapter browserHttpAdapter = WiltBrowserHTTPAdapter();
}
