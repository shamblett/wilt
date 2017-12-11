/*
 * Package : WiltServerClient
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 04/06/2013
 * Copyright :  S.Hamblett@OSCF
 * 
 * An instance of Wilt specialised for use in the server.
 */

library wilt_server_client;

import 'dart:convert';
import 'dart:async';

import 'package:wilt/wilt.dart';
import 'package:http/http.dart' as http;
import 'package:json_object_lite/json_object_lite.dart' as jsonobject;

part 'src/httpAdapters/wilt_server_http_adapter.dart';

/// The Wilt server client
class WiltServerClient extends Wilt {
  static WiltServerHTTPAdapter serverHttpAdapter = new WiltServerHTTPAdapter();

  WiltServerClient(host, port, scheme, [Object clientCompletion])
      : super(host, port, scheme, serverHttpAdapter, clientCompletion);
}
