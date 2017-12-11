/*
 * Package : WiltBrowserClient
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 04/06/2013
 * Copyright :  S.Hamblett@OSCF
 * 
 * An instance of Wilt specialised for use in the browser
 */

library wilt_browser_client;

import 'package:wilt/wilt.dart';
import 'dart:html' as html;
import 'dart:convert';
import 'dart:async';
import 'package:json_object_lite/json_object_lite.dart' as jsonobject;

part 'src/httpAdapters/wilt_browser_http_adapter.dart';

/// The Wilt browser client
class WiltBrowserClient extends Wilt {
  static WiltBrowserHTTPAdapter browserHttpAdapter =
      new WiltBrowserHTTPAdapter();

  WiltBrowserClient(host, port, scheme, [Object clientCompletion])
      : super(host, port, scheme, browserHttpAdapter, clientCompletion);
}
