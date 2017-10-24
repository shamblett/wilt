/*
 * Package : Wilt
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 04/06/2013
 * Copyright :  S.Hamblett@OSCF
 *
 * The Wilt class provides core functionality for interacting with CouchDB databases from
 * both the browser and the server. Wilt should not be instantiated standalone but rather through
 * inclusion of one of the wilt_browser_client or wilt_server_client files.
 * 
 * Further documentation can be found in the docs folder.
 * 
 */

part of wilt;

class Wilt {
  /// URL constant for CouchDB SESSION function
  static const String session = "/_session";

  /// URL constant for CouchDB STATS function
  static const String stats = "/_stats";

  /// URL constant for CouchDB ALLDBS function
  static const String alldbs = "/_all_dbs";

  /// URL constant for CouchDB ALLDOCS function
  static const String alldocs = "/_all_docs";

  /// URL constant for CouchDB BULKDOCS function
  static const String bulkdocs = "/_bulk_docs";

  /// URL constant for CouchDB UUID function
  static const String uuids = "/_uuids";

  /// Etag header
  static const String etag = 'etag';

  /// AUTH_BASIC denotes Basic HTTP authentication.
  /// If login is called AUTH_BASIC is set, otherwise it defaults to AUTH_NONE
  static const String authBasic = 'basic';

  /// No authentication
  static const String authNone = 'none';

  /// Operation types and method definitions
  static const String gett = 'GET_GET';
  static const String headd = 'HEAD_HEAD';
  static const String postt = 'POST_POST';
  static const String putt = 'PUT_PUT';
  static const String deletee = 'DELETE_DELETE';
  static const String copy = 'COPY_COPY';
  static const String getDocumentt = 'GET_DOCUMENT';
  static const String deleteDocumentt = 'DELETE_DOCUMENT';
  static const String putDocumentt = 'PUT_DOCUMENT';
  static const String postDocumentt = 'POST_DOCUMENT';
  static const String postDocumentStringg = 'POST_DOCUMENTSTRING';
  static const String copyDocumentt = 'COPY_DOCUMENT';
  static const String getAllDocss = 'GET_ALLDOCS';
  static const String bulkk = 'POST_BULK';
  static const String bulkStringg = 'POST_BULKSTRING';
  static const String createDatabasee = 'PUT_DATABASE';
  static const String deleteDatabasee = 'DELETE_DATABASE';
  static const String databaseInfo = 'GET_DATABASEINFO';
  static const String getSessionn = 'GET_SESSION';
  static const String getStatss = 'GET_STATS';
  static const String getAllDbss = 'GET_ALLDBS';
  static const String createAttachmentt = 'PUT_CREATEATTACH';
  static const String updateAttachmentt = 'PUT_UPDATEATTACH';
  static const String deleteAttachmentt = 'DELETE_ATTACH';
  static const String getAttachmentt = 'GET_ATTACH';
  static const String generateIdss = 'GET_IDS';

  /// Please use the wilt_browser_client or wilt_server_client import files to
  /// instantiate a Wilt object for use in either the browser or server environment.
  /// You can do this here but you must supply either a browser or server HTTP adapter
  /// to use.
  Wilt(this._host, this._port, this._scheme, this._httpAdapter,
      [this._clientCompletion = null]) {
    if ((host == null) || (port == null) || (scheme == null)) {
      throw new WiltException(WiltException.badConstParams);
    }

    if (_httpAdapter == null) {
      throw new WiltException(WiltException.badConstNoAdapter);
    }
  }

  /// Database name
  String _db = null;
  String get db => _db;
  set db(String name) => _db = name;

  /// Change notification database name
  String changeNotificationDbName = null;

  /// Host name
  String _host = null;
  String get host => _host;

  /// Port number
  String _port = null;
  String get port => _port;

  /// HTTP scheme
  String _scheme = null;
  String get scheme => _scheme;

  /// HTTP Adapter
  WiltHTTPAdapter _httpAdapter = null;
  set httpAdapter(WiltHTTPAdapter adapter) => _httpAdapter = adapter;
  WiltHTTPAdapter get httpAdapter => _httpAdapter;

  /// Change notification
  _WiltChangeNotification _changeNotifier = null;

  /// Change notification event stream
  /// This is a broadcast stream so can support more than one listener.
  Stream<WiltChangeNotificationEvent> get changeNotification =>
      _changeNotifier.changeNotification.stream;

  /// Change notification paused state
  bool get changeNotificationsPaused => _changeNotifier.pause;

  /// Completion function
  var _clientCompletion = null;

  /// Completion callback
  set resultCompletion(final Object completion) {
    _clientCompletion = completion;
  }

  /// Response getter for completion callbacks
  jsonobject.JsonObjectLite _completionResponse;

  jsonobject.JsonObjectLite get completionResponse => _completionResponse;

  /// Authentication, user name
  String _user = null;

  /// Authentication, user password
  String _password = null;

  /// Authentication, type
  String authenticationType = authNone;

  /// The internal HTTP request method. This wraps the
  /// HTTP adapter class.
  Future<jsonobject.JsonObjectLite> _httpRequest(String method, String url,
      {String data: null, Map headers: null}) {
    /* Build the request for the HttpAdapter*/
    final Map wiltHeaders = new Map<String, String>();
    wiltHeaders["Accept"] = "application/json";
    if (headers != null) wiltHeaders.addAll(headers);

    /* Build the URL */
    final String wiltUrl = "$scheme$host:$port$url";

    /* Check for authentication */
    if (_user != null) {
      switch (authenticationType) {
        case authBasic:
          final String authStringToEncode = "$_user:$_password";
          final String encodedAuthString =
              CryptoUtils.bytesToBase64(authStringToEncode.codeUnits);
          final String authString = "Basic $encodedAuthString";
          wiltHeaders['Authorization'] = authString;
          break;

        case authNone:
          break;
      }
    }

    /* Execute the request*/
    final Future<jsonobject.JsonObjectLite> completion =
        _httpAdapter.httpRequest(method, wiltUrl, data, wiltHeaders)
          ..then((jsonResponse) {
            if (_clientCompletion != null) {
              _completionResponse = jsonResponse;
              _clientCompletion();
            }
          });

    return completion;
  }

  /// Takes a URL and key/value pair for a URL parameter and adds this
  /// to the query parameters of the URL.
  String _setURLParameter(String url, String key, String value) {
    final originalUrl = Uri.parse(url);
    final Map queryParams = originalUrl.queryParameters;
    final Map newQueryParams = new Map<String, String>.from(queryParams);
    newQueryParams[key] = value;

    final newUrl = new Uri(
        scheme: originalUrl.scheme,
        userInfo: originalUrl.userInfo,
        host: originalUrl.host,
        port: originalUrl.port,
        path: originalUrl.path,
        queryParameters: newQueryParams);

    final String returnUrl = newUrl.toString();
    return returnUrl /* Private */;
  }

  /// Conditions the URL for use by Wilt and checks for
  /// a valid database by default.
  String _conditionUrl(String url) {
    if (db == null) {
      return WiltException.noDatabaseSpecified;
    }
    if (url == null) {
      return '/';
    }
    String urlRet = url;
    /* The first char of the URL should be a slash. */
    if (!url.startsWith('/')) {
      urlRet = "/$urlRet";
    }
    if (db != null) {
      urlRet = "/$db$urlRet";
    }
    return urlRet;
  }

  /// Raise an exception from a future API call.
  /// If we are using completion throw an exception as normal.
  Future<WiltException> _raiseException(String name) {
    if (_clientCompletion == null) {
      return new Future.error(new WiltException(name));
    } else {
      throw new WiltException(name);
    }
  }

  /// Basic method where only a URL and a method is passed.
  /// Wilt applies no checks to this URL nor does it add the
  /// database, the format of this is entirely up to the user.
  ///
  /// This can be used for CouchDb functions that are not directly supported by Wilt,
  /// e.g views, attachments and design documents.
  Future<jsonobject.JsonObjectLite> httpRequest(String url,
      {String method: "GET"}) {
    return _httpRequest(method, url);
  }

  /// Performs an HTTP GET operation, the URL is conditioned and
  /// the current database added.
  Future get(String url) {
    final String url1 = _conditionUrl(url);
    if (url1 == WiltException.noDatabaseSpecified) {
      return _raiseException(WiltException.noDatabaseSpecified);
    }

    /* Perform the get */
    return _httpRequest('GET', url1);
  }

  /// Performs a HTTP HEAD operation, the URL is conditioned and
  /// the current database added.
  Future head(String url) {
    final String url1 = _conditionUrl(url);
    if (url1 == WiltException.noDatabaseSpecified) {
      return _raiseException(WiltException.noDatabaseSpecified);
    }

    /* Perform the head */
    return _httpRequest(headd, url1);
  }

  /// Performs a HTTP POST operation,, the URL is conditioned and
  /// the current database added.
  Future post(String url, String data, [Map headers]) {
    final String url1 = _conditionUrl(url);
    if (url1 == WiltException.noDatabaseSpecified) {
      return _raiseException(WiltException.noDatabaseSpecified);
    }

    /* Perform the post */
    return _httpRequest('POST', url1, data: data, headers: headers);
  }

  /// Performs a HTTP PUT operation,, the URL is conditioned and
  /// the current database added.
  Future put(String url, String data, [Map headers]) {
    final String url1 = _conditionUrl(url);
    if (url1 == WiltException.noDatabaseSpecified) {
      return _raiseException(WiltException.noDatabaseSpecified);
    }

    /* Perform the put */
    return _httpRequest('PUT', url1, data: data, headers: headers);
  }

  /// Performs a HTTP DELETE operation,, the URL is conditioned and
  /// the current database added.
  Future delete(String url) {
    final String url1 = _conditionUrl(url);
    if (url1 == WiltException.noDatabaseSpecified) {
      return _raiseException(WiltException.noDatabaseSpecified);
    }

    /* Perform the delete */
    return _httpRequest('DELETE', url1);
  }

  /// Performs an HTTP GET operation for the supplied document id and
  /// optional revision. If withAttachments is set the the body of
  /// any attachments are also supplied, note this could make this
  /// a large transfer.
  Future getDocument(String id,
      [String rev = null, bool withAttachments = false]) {
    if (id == null) {
      return _raiseException(WiltException.getDocNoId);
    }

    String url = id;
    if (rev != null) {
      url = _setURLParameter(url, 'rev', rev);
    }

    if (withAttachments) {
      url = _setURLParameter(url, 'attachments', 'true');
    }

    url = _conditionUrl(url);
    return _httpRequest('GET_DOCUMENT', url);
  }

  /// Gets a documents current revision, returns null if
  /// the document does not exist.
  Future getDocumentRevision(String id) {
    if (id == null) {
      return _raiseException(WiltException.getDocRevNoId);
    }

    final Completer completer = new Completer();
    head(id).then((res) {
      final jsonobject.JsonObjectLite headers =
      new jsonobject.JsonObjectLite.fromMap(res.allResponseHeaders);
      if (headers != null) {
        if (headers.containsKey(etag)) {
          String ver = headers.etag;
          ver = ver.substring(1, ver.length - 1);
          completer.complete(ver);
        } else {
          completer.complete(null);
        }
      }
    });

    return completer.future;
  }

  /// DELETE's the specified document. Must have a revision.
  /// If preserve is set to true the whole document is preserved
  /// and marked as deleted otherwise only a stub document is
  /// kept. Default is to not preserve.
  Future deleteDocument(String id, String rev, [bool preserve = false]) {
    if ((id == null) || (rev == null)) {
      return _raiseException(WiltException.deleteDocNoIdRev);
    }
    final Completer completer = new Completer();

    /* Check the preserve flag */
    if (preserve) {
      getDocument(id).then((jsonobject.JsonObjectLite res) {
        if (res != null) {
          jsonobject.JsonObjectLite resp = res.jsonCouchResponse;
          resp = WiltUserUtils.addDocumentDeleteJo(resp);
          putDocument(id, resp).then((res1) {
            completer.complete(res1);
          });
        } else {
          completer.complete(null);
        }
      });
      return completer.future;
    } else {
      String url = id;
      url = _setURLParameter(url, 'rev', rev);
      url = _conditionUrl(url);
      return _httpRequest('DELETE_DOCUMENT', url);
    }
  }

  /// PUT's to the specified  document.
  ///
  /// For an update the revision must be specified, this can be in the
  /// document body as a _rev parameter or specified in the call in which
  /// case this will be added to the document body.
  Future putDocument(String id, jsonobject.JsonObjectLite document,
      [String rev = null]) {
    if ((id == null) || (document == null)) {
      return _raiseException(WiltException.putDocNoIdBody);
    }

    /* Check for a revision */
    String jsonData = null;

    try {
      if (rev != null) {
        jsonData = WiltUserUtils.addDocumentRev(document, rev);
      } else {
        jsonData = JSON.encode(document);
      }
    } catch (e) {
      return _raiseException(WiltException.putDocCantStringify);
    }

    final String url = _conditionUrl(id);
    return _httpRequest(putDocumentt, url, data: jsonData);
  }

  /// PUT's to the specified  document where the document is supplied as
  /// a JSON string. Must be used if '_id' and or '_rev' are needed.
  Future putDocumentString(String id, String document, [String rev = null]) {
    if ((id == null) || (document == null)) {
      return _raiseException(WiltException.putDocStringNoIdBody);
    }

    /* Check for a revision */
    String id1 = id;
    if (rev != null) {
      id1 = "$id1?rev=$rev";
    }
    final String url = _conditionUrl(id1);
    return _httpRequest(putDocumentt, url, data: document);
  }

  /// POST's the specified document.
  /// An optional path to the document can be specified.
  Future postDocument(jsonobject.JsonObjectLite document, {String path: null}) {
    if (document == null) {
      return _raiseException(WiltException.postDocNoBody);
    }

    String url = "";
    if (path != null) url = "$url/$path";

    /* Set the content type for a post */
    final Map headers = new Map<String, String>();
    headers["Content-Type"] = "application/json";

    String jsonData = null;
    try {
      jsonData = JSON.encode(document);
    } catch (e) {
      return _raiseException(WiltException.postDocCantStringify);
    }

    url = _conditionUrl(url);
    return _httpRequest(postDocumentt, url, data: jsonData, headers: headers);
  }

  /// POST's to the specified  document where the document is supplied as
  /// a JSON string. Must be used if '_id' and or '_rev' are needed.
  Future postDocumentString(String document, {String path: null}) {
    if (document == null) {
      return _raiseException(WiltException.postDocStringNoBody);
    }

    String url = "";
    if (path != null) url = "$url/$path";

    /* Set the content type for a post */
    final Map headers = new Map<String, String>();
    headers["Content-Type"] = "application/json";

    url = _conditionUrl(url);
    return _httpRequest('POST_DOCUMENT_STRING', url,
        data: document, headers: headers);
  }

  /// Copies the source document to the destination document with an optional revision
  /// NOTE this method uses the CouchDB COPY method which is not standard HTTP.
  Future copyDocument(String sourceId, String destinationId,
      [String rev = null]) {
    if (sourceId == null) {
      return _raiseException(WiltException.copyDocNoSrcId);
    }

    if (destinationId == null) {
      return _raiseException(WiltException.copyDocNoDestId);
    }

    String url = sourceId;

    /* Create the special COPY header */
    final Map headers = new Map<String, String>();
    String destination = destinationId;
    if (rev != null) destination = "$destinationId?rev=$rev";
    headers['Destination'] = destination;

    url = _conditionUrl(url);
    return _httpRequest('COPY_DOCUMENT', url, headers: headers);
  }

  /// Get all documents.
  /// The parameters should be self explanatory and are addative.
  /// Refer to the CouchDb documentation for further explanation.
  Future getAllDocs(
      {bool includeDocs: false,
      int limit: null,
      String startKey: null,
      String endKey: null,
      List<String> keys: null,
      bool descending: false}) {
    /* Validate the parameters */
    if ((limit != null) && (limit < 0)) {
      return _raiseException(WiltException.getAllDocsLimit);
    }

    String url = alldocs;

    /* Check the parameters and build the URL as needed */
    if (includeDocs) {
      url = _setURLParameter(url, 'include_docs', "true");
    }

    if (limit != null) {
      url = _setURLParameter(url, 'limit', limit.toString());
    }

    if (startKey != null) {
      final String jsonStartkey = '"$startKey"';
      url = _setURLParameter(url, 'startkey', jsonStartkey);
    }

    if (endKey != null) {
      final String jsonEndkey = '"$endKey"';
      url = _setURLParameter(url, 'endkey', jsonEndkey);
    }

    if (descending) {
      url = _setURLParameter(url, 'descending', descending.toString());
    }

    if (keys != null) {
      final String keyString = JSON.encode(keys);
      url = _setURLParameter(url, 'keys', keyString);
    }

    url = _conditionUrl(url);
    return _httpRequest('GET_ALLDOCS', url);
  }

  /// Bulk insert
  /// Bulk inserts a list of documents
  Future bulk(List<jsonobject.JsonObjectLite> docs,
      [bool allOrNothing = false]) {
    /* Validate the parameters */
    if (docs == null) {
      return _raiseException(WiltException.bulkNoDocList);
    }

    String url = bulkdocs;

    if (allOrNothing) {
      url = _setURLParameter(url, 'all_or_nothing', allOrNothing.toString());
    }

    /* Create the bulk insertion data structure */
    final Map documentMap = new Map<String, List>();
    documentMap["docs"] = docs;
    String docString = null;
    try {
      docString = JSON.encode(documentMap);
    } catch (e) {
      return _raiseException(WiltException.bulkCantStringify);
    }

    /* Must set the content type for a post */
    final Map headers = new Map<String, String>();
    headers["Content-Type"] = "application/json";

    url = _conditionUrl(url);
    return _httpRequest(bulkk, url, data: docString, headers: headers);
  }

  /// Bulk insert JSON string version.
  /// Must be used if '_id' and or '_rev' are needed in ANY of the documents
  Future bulkString(String docs, [bool allOrNothing = false]) {
    /* Validate the parameters */
    if (docs == null) {
      return _raiseException(WiltException.bulkStringNoDoc);
    }

    String url = bulkdocs;

    if (allOrNothing) {
      url = _setURLParameter(url, 'all_or_nothing', allOrNothing.toString());
    }

    /* Must set the content type for a post */
    final Map headers = new Map<String, String>();
    headers["Content-Type"] = "application/json";

    url = _conditionUrl(url);
    return _httpRequest(bulkStringg, url, data: docs, headers: headers);
  }

  /// Creates a database with the specified name.
  Future createDatabase(String name) {
    if ((name == null)) {
      return _raiseException(WiltException.createDbNoName);
    }

    /* The first char of the URL should be a slash. */
    String url = name;
    if (!url.startsWith('/')) {
      url = "/$url";
    }

    return _httpRequest(createDatabasee, url);
  }

  /// Deletes the specified database
  Future deleteDatabase(String name) {
    if (name == null) {
      return _raiseException(WiltException.deleteDbNoName);
    }

    /* The first char of the URL should be a slash. */
    String url = name;
    if (!url.startsWith('/')) {
      url = "/$url";
    }

    /* Null the current database if we have deleted it */
    if (name == db) _db = null;

    return _httpRequest(deleteDatabasee, url);
  }

  /// Get information about a database
  Future getDatabaseInfo([String dbName = null]) {
    String name;
    if (dbName != null) {
      name = dbName;
    } else {
      name = db;
    }

    final String url = "/$name";

    return _httpRequest(databaseInfo, url);
  }

  /// Get current session information from CouchDB
  Future getSession() {
    final String url = session;

    return _httpRequest(getSessionn, url);
  }

  /// Get current stats from CouchDB
  Future getStats() {
    final String url = stats;

    return _httpRequest(getStatss, url);
  }

  /// Get all the databases from CouchDB
  Future getAllDbs() {
    final String url = alldbs;

    return _httpRequest(getAllDbss, url);
  }

  /// Create an attachment on an existing document.
  /// contentType is in the form of a mime type e.g. 'image/png'
  /// If the document needs to be created as well as the attachment set the rev to ''
  Future createAttachment(String docId, String attachmentName, String rev,
      String contentType, String payload) {
    /**
    * Check all parameters are supplied
    */
    if (docId == null) {
      return _raiseException(WiltException.createAttNoDocId);
    }

    if (attachmentName == null) {
      return _raiseException(WiltException.createAttNoName);
    }

    if (rev == null) {
      return _raiseException(WiltException.createAttNoRev);
    }

    if (contentType == null) {
      return _raiseException(WiltException.createAttNoContentType);
    }

    if (payload == null) {
      return _raiseException(WiltException.createAttNoPayload);
    }

    /**
     * Set the headers
     */
    final Map headers = new Map<String, String>();
    headers["Content-Type"] = contentType;

    /**
     * Make the PUT request
     */
    String url;
    if (rev != '') {
      url = "$docId/$attachmentName?rev=$rev";
    } else {
      url = "$docId/$attachmentName";
    }

    url = _conditionUrl(url);
    return _httpRequest(createAttachmentt, url,
        data: payload, headers: headers);
  }

  /// Update an attachment on an existing document.
  /// contentType is in the form of a mime type e.g. 'image/png'
  Future updateAttachment(String docId, String attachmentName, String rev,
      String contentType, String payload) {
    /**
    * Check all parameters are supplied
    */
    if (docId == null) {
      return _raiseException(WiltException.updateAttNoDocId);
    }

    if (attachmentName == null) {
      return _raiseException(WiltException.updateAttNoName);
    }

    if (rev == null) {
      return _raiseException(WiltException.updateAttNoRev);
    }

    if (contentType == null) {
      return _raiseException(WiltException.updateAttNoContentType);
    }

    if (payload == null) {
      return _raiseException(WiltException.updateAttNoPayload);
    }

    /**
     * Set the headers
     */
    final Map headers = new Map<String, String>();
    headers["Content-Type"] = contentType;

    String url = "$docId/$attachmentName?rev=$rev";

    url = _conditionUrl(url);
    return _httpRequest(updateAttachmentt, url,
        data: payload, headers: headers);
  }

  /// Delete an attachment
  Future deleteAttachment(String docId, String attachmentName, String rev) {
    if (docId == null) {
      return _raiseException(WiltException.deleteAttNoDocId);
    }

    if (attachmentName == null) {
      return _raiseException(WiltException.deleteAttNoName);
    }

    if (rev == null) {
      return _raiseException(WiltException.deleteAttNoRev);
    }

    String url = "$docId/$attachmentName?rev=$rev";

    url = _conditionUrl(url);
    return _httpRequest(deleteAttachmentt, url);
  }

  /// Get an attachment
  Future getAttachment(String docId, String attachmentName) {
    if (docId == null) {
      return _raiseException(WiltException.getAttNoDocId);
    }

    if (attachmentName == null) {
      return _raiseException(WiltException.getAttNoName);
    }

    String url = "$docId/$attachmentName";

    url = _conditionUrl(url);
    return _httpRequest(getAttachmentt, url);
  }

  /// Change notification start, see the WiltChangeNotification class for more details
  ///
  /// If a database name is not supplied the currently selected database is used.
  ///
  /// If auth credentials are not set raise an exception.
  void startChangeNotification(
      [WiltChangeNotificationParameters parameters = null,
      String databaseName = null]) {
    if (_user == null) {
      throw new WiltException(WiltException.cnNoAuth);
    }
    String name;
    if (databaseName == null) {
      name = db;
    } else {
      name = databaseName;
    }

    changeNotificationDbName = name;
    _changeNotifier = new _WiltChangeNotification(
        _host, _port, _scheme, _httpAdapter, name, parameters);
  }

  /// Change notification stop, see the WiltChangeNotification class for more details
  ///
  /// Note that this destroys the internal changeNotifier object which can only be
  /// reinstated by a call to startChangeNotification.
  void stopChangeNotification() {
    _changeNotifier.stopNotifications();
    _changeNotifier = null;
    changeNotificationDbName = null;
  }

  /// Change the parameter set for change notifications.
  ///
  /// Note that database name, host, port and scheme are not changeable.
  void updateChangeNotificationParameters(
      WiltChangeNotificationParameters parameters) {
    if (parameters == null) {
      throw new WiltException(WiltException.updateCnpNoParams);
    }

    if (_changeNotifier == null) {
      throw new WiltException(WiltException.updateCnpNoNotifier);
    }

    _changeNotifier.parameters = parameters;
  }

  /// Pause change notifications
  void pauseChangeNotifications() {
    _changeNotifier.pause = true;
    _changeNotifier.stopNotifications();
  }

  /// Restart change notifications after a pause
  void restartChangeNotifications() {
    _changeNotifier.pause = false;
    _changeNotifier.restartChangeNotifications();
  }

  /// Authentication.
  /// Updates the login credentials in Wilt that will be used for all further
  /// requests to CouchDB. Both user name and password must be set, even if one
  /// or the other is '' i.e empty. After logging in all communication with CouchDB
  /// is made using the selected authentication method.
  void login(String user, String password) {
    if ((user == null) || (password == null)) {
      throw new WiltException(WiltException.loginWrongParams);
    }

    _user = user;
    _password = password;
    authenticationType = authBasic;

    /* Set the auth details for change notification */
    _httpAdapter.notificationAuthParams(_user, _password, authenticationType);
  }

  /// Ask CouchDB to generate document Id's.
  Future generateIds([int amount = 10]) {
    if (amount < 1) {
      return _raiseException(WiltException.genIdsAmount);
    }

    String url = uuids;

    url = url + "?count=${amount}";

    return _httpRequest(generateIdss, url);
  }
}
