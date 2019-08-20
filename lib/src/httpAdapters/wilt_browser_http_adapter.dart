/*
 * Packge : Wilt
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 04/06/2013
 * Copyright :  S.Hamblett@OSCF
 *
 * Browser(dart:html) CouchDB HTTP adapter for Wilt.
 *  
 * This always returns a json Object the format of which is documented in
 * the Result Interface document
 *                      
 */

part of wilt_browser_client;

/// Browser HTTP adapter
class WiltBrowserHTTPAdapter implements WiltHTTPAdapter {
  /// Construction
  WiltBrowserHTTPAdapter();

  /// User for change notification authorization
  String _user;

  /// Password for change notification authorization
  String _password;

  /// Auth Type for change notification authorization
  String _authType;

  /// Processes the HTTP request, returning the server's response
  /// as a future
  @override
  Future<dynamic> httpRequest(String method, String url,
      [String data, Map<String, String> headers]) {
    // Initialise
    final Completer<dynamic> completer = Completer<dynamic>();

    //Successful completion
    void onSuccess(html.HttpRequest response) {
      //  Process the success response, note that an error response from CouchDB is
      // treated as an error, not as a success with an 'error' field in it.
      final dynamic jsonResponse = jsonobject.JsonObjectLite<dynamic>();
      jsonResponse.error = false;
      jsonResponse.errorCode = 0;
      jsonResponse.successText = null;
      jsonResponse.errorText = null;
      jsonResponse.allResponseHeader = null;
      jsonResponse.method = method;
      jsonResponse.responseText = response.responseText;

      // Check the header, if application/json try and decode it,
      // otherwise its just raw data, ie an attachment.
      if (response.responseHeaders.containsValue('application/json')) {
        dynamic couchResp;
        try {
          couchResp = json.decode(response.responseText);
        } on Exception {
          jsonResponse.error = true;
          final dynamic errorAsJson = jsonobject.JsonObjectLite<dynamic>();
          errorAsJson.error = 'json Decode Error';
          errorAsJson.reason = 'None';
          jsonResponse.jsonCouchResponse = errorAsJson;
          // Set the response headers
          jsonResponse.allResponseHeaders = response.getAllResponseHeaders();
          // Complete the request
          if (!completer.isCompleted) {
            completer.complete(jsonResponse);
          }
        }

        if ((couchResp is Map) && (couchResp.containsKey('error'))) {
          jsonResponse.error = true;
          final dynamic errorAsJson = jsonobject.JsonObjectLite<dynamic>();
          errorAsJson.error = 'CouchDb Error';
          errorAsJson.reason = couchResp['reason'];
          jsonResponse.jsonCouchResponse = errorAsJson;
          // Set the response headers
          jsonResponse.allResponseHeaders = response.getAllResponseHeaders();
          // Complete the request
          if (!completer.isCompleted) {
            completer.complete(jsonResponse);
          }
        }

        // Success response
        if (method != Wilt.headd) {
          final jsonobject.JsonObjectLite<dynamic> successAsJson =
              jsonobject.JsonObjectLite<dynamic>.fromJsonString(
                  response.responseText);
          jsonResponse.jsonCouchResponse = successAsJson;
        }
      } else {
        final dynamic successAsJson = jsonobject.JsonObjectLite<dynamic>();
        successAsJson.ok = true;
        successAsJson.contentType = response.responseHeaders['content-type'];
        jsonResponse.jsonCouchResponse = successAsJson;
      }

      // Set the response headers
      jsonResponse.allResponseHeaders = response.getAllResponseHeaders();
      // Complete the request
      if (!completer.isCompleted) {
        completer.complete(jsonResponse);
      }
    }

    /// Error completion
    void onError(dynamic response) {
      // Get the HTTP request from the progress event
      final html.HttpRequest req = response.target;

      // Process the error response
      final dynamic jsonResponse = jsonobject.JsonObjectLite<dynamic>();
      jsonResponse.method = method;
      jsonResponse.error = true;
      jsonResponse.successText = null;
      jsonResponse.responseText = req.responseText;
      jsonResponse.errorCode = req.status;
      if ((req.status != 0) && (method != Wilt.headd)) {
        final jsonobject.JsonObjectLite<dynamic> errorAsJson =
            jsonobject.JsonObjectLite<dynamic>.fromJsonString(req.responseText);
        jsonResponse.jsonCouchResponse = errorAsJson;
      } else {
        final dynamic errorAsJson = jsonobject.JsonObjectLite<dynamic>();
        errorAsJson.error = 'Invalid HTTP response';
        errorAsJson.reason = 'HEAD or status code of 0';
        jsonResponse.jsonCouchResponse = errorAsJson;
      }

      // Set the response headers
      jsonResponse.allResponseHeaders = req.getAllResponseHeaders();

      // Complete the request
      if (!completer.isCompleted) {
        completer.complete(jsonResponse);
      }
    }

    // Condition the input method string to get the HTTP method
    final String httpMethod = method.split('_')[0];

    // Query CouchDB over HTTP
    html.HttpRequest.request(url,
        method: httpMethod,
        withCredentials: true,
        responseType: null,
        requestHeaders: headers,
        sendData: data)
      ..then(onSuccess)
      ..catchError(onError);

    return completer.future;
  }

  /// Specialised 'get' for change notifications
  @override
  Future<String> getString(String url) {
    final Completer<String> completer = Completer<String>();

    // Must have authentication
    final Map<String, String> wiltHeaders = Map<String, String>();
    wiltHeaders['accept'] = 'application/json';
    if (_user != null) {
      switch (_authType) {
        case Wilt.authBasic:
          final String authStringToEncode = '$_user:$_password';
          final String encodedAuthString =
              const Base64Encoder().convert(authStringToEncode.codeUnits);
          final String authString = 'Basic $encodedAuthString';
          wiltHeaders['authorization'] = authString;
          break;
        case Wilt.authNone:
          break;
      }
    }

    html.HttpRequest.request(url,
            method: 'GET', withCredentials: true, requestHeaders: wiltHeaders)
        .then((dynamic request) {
      completer.complete(request.responseText);
    });

    return completer.future;
  }

  /// Authentication parameters for change notification
  @override
  void notificationAuthParams(String user, String password, String authType) {
    _user = user;
    _password = password;
    _authType = authType;
  }
}
