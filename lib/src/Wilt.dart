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

  /**
   *  URL constant for CouchDB SESSION function 
   */
  static const String SESSION = "/_session";

  /**
   *  URL constant for CouchDB STATS function 
   */
  static const String STATS = "/_stats";

  /**
   *  URL constant for CouchDB ALLDBS function 
   */
  static const String ALLDBS = "/_all_dbs";

  /**
   *  URL constant for CouchDB ALLDOCS function 
   */
  static const String ALLDOCS = "/_all_docs";

  /**
   *  URL constant for CouchDB BULKDOCS function 
   */
  static const String BULKDOCS = "/_bulk_docs";

  /**
   *  URL constant for CouchDB UUID function 
   */
  static const String UUIDS = "/_uuids";

  /**
   *
   * AUTH_BASIC denotes Basic HTTP authentication. 
   * If login is called AUTH_BASIC is set, otherwise it defaults to AUTH_NONE
   * 
   */
  static const String AUTH_BASIC = 'basic';

  /**
   * No authentication 
   */
  static const String AUTH_NONE = 'none';

  /**
   * Operation types and method definitions
   */
  static const GET = 'GET_GET';
  static const HEAD = 'HEAD_HEAD';
  static const POST = 'POST_POST';
  static const PUT = 'PUT_PUT';
  static const DELETE = 'DELETE_DELETE';
  static const COPY = 'COPY_COPY';
  static const GET_DOCUMENT = 'GET_DOCUMENT';
  static const DELETE_DOCUMENT = 'DELETE_DOCUMENT';
  static const PUT_DOCUMENT = 'PUT_DOCUMENT';
  static const POST_DOCUMENT = 'POST_DOCUMENT';
  static const POST_DOCUMENT_STRING = 'POST_DOCUMENTSTRING';
  static const COPY_DOCUMENT = 'COPY_DOCUMENT';
  static const GET_ALLDOCS = 'GET_ALLDOCS';
  static const BULK = 'POST_BULK';
  static const BULK_STRING = 'POST_BULKSTRING';
  static const CREATE_DATABASE = 'PUT_DATABASE';
  static const DELETE_DATABASE = 'DELETE_DATABASE';
  static const DATABASE_INFO = 'GET_DATABASEINFO';
  static const GET_SESSION = 'GET_SESSION';
  static const GET_STATS = 'GET_STATS';
  static const GET_ALLDBS = 'GET_ALLDBS';
  static const CREATE_ATTACHMENT = 'PUT_CREATEATTACH';
  static const UPDATE_ATTACHMENT = 'PUT_UPDATEATTACH';
  static const DELETE_ATTACHMENT = 'DELETE_ATTACH';
  static const GET_ATTACHMENT = 'GET_ATTACH';
  static const GENERATE_IDS = 'GET_IDS';

  /** 
   * Database name
   */
  String _db = null;
  String get db => _db;
  set db(String name) => _db = name;

  /**
   * Change notification database name
   */
  String changeNotificationDbName = null;

  /** 
   * Host name
   */
  String _host = null;
  String get host => _host;

  /** 
   * Port number
   */
  String _port = null;
  String get port => _port;

  /** 
   * HTTP scheme
   */
  String _scheme = null;
  String get scheme => _scheme;

  /**
   * HTTP Adapter
   */
  WiltHTTPAdapter _httpAdapter = null;
  set httpAdapter(WiltHTTPAdapter adapter)=>_httpAdapter = adapter;
  WiltHTTPAdapter get httpAdapter  => _httpAdapter;
  
  /**
   * Change notification 
   */
  _WiltChangeNotification _changeNotifier = null;

  /**
   * Change notification event stream
   * 
   * This is a broadcast stream so can support more than one listener.
   * 
   */
  Stream<WiltChangeNotificationEvent> get changeNotification =>
      _changeNotifier.changeNotification.stream;
  /**
   * Change notification paused state
   */
  bool get changeNotificationsPaused => _changeNotifier.pause;

  /**
   * Completion function 
   */
  var _clientCompletion = null;

  /**
   *  Completion callback 
   */
  set resultCompletion(var completion) {

    _clientCompletion = completion;
  }

  /**
   *  Response getter for completion callbacks 
   */
  jsonobject.JsonObject _completionResponse;
  jsonobject.JsonObject get completionResponse => _completionResponse;

  /**
   *  Authentication, user name
   */
  String _user = null;
  /**
   *  Authentication, user password
   */
  String _password = null;
  /**
   *  Authentication, type
   */
  String authenticationType = AUTH_NONE;

  Wilt(this._host, this._port, this._scheme, this._httpAdapter, [this._clientCompletion = null]) {

    if ((host == null) || (port == null) || (scheme == null)) {

      throw new WiltException(
          'Bad construction - some or all required parameters are null');

    }
    
    if  ( _httpAdapter == null) {
      throw new WiltException(
                'Bad construction - you must instantiate Wilt with a HTTP Adapter');
    }

  }

  /**
   *  The internal HTTP request method. This wraps the
   *  HTTP adapter class. 
  */
  Future<jsonobject.JsonObject> _httpRequest(String method, String url, {String data: null, Map headers:
      null}) {


    /* Build the request for the HttpAdapter*/
    Map wiltHeaders = new Map<String, String>();
    wiltHeaders["Accept"] = "application/json";
    if (headers != null) wiltHeaders.addAll(headers);

    /* Build the URL */
    String wiltUrl = "$scheme$host:$port$url";

    /* Check for authentication */
    if (_user != null) {

      switch (authenticationType) {

        case AUTH_BASIC:

          String authStringToEncode = "$_user:$_password";
          String encodedAuthString = CryptoUtils.bytesToBase64(authStringToEncode.codeUnits);
          String authString = "Basic $encodedAuthString";
          wiltHeaders['Authorization'] = authString;
          break;

        case AUTH_NONE:

          break;
      }

    }

    /* Execute the request*/
    Future<jsonobject.JsonObject> completion = _httpAdapter.httpRequest(method, wiltUrl, data, wiltHeaders)..then(
        (jsonResponse) {

          if ( _clientCompletion != null ) {
            
            _completionResponse = jsonResponse;
            _clientCompletion();
         
          }

       });
    
    return completion;

  }


  /**
   * Takes a URL and key/value pair for a URL parameter and adds this
   * to the query parameters of the URL.
   */
  String _setURLParameter(String url, String key, String value) {

    var originalUrl = Uri.parse(url);
    Map queryParams = originalUrl.queryParameters;
    Map newQueryParams = new Map<String, String>.from(queryParams);
    newQueryParams[key] = value;

    var newUrl = new Uri(scheme: originalUrl.scheme, userInfo:
        originalUrl.userInfo, host: originalUrl.host, port: originalUrl.port, path:
        originalUrl.path, queryParameters: newQueryParams);


    String returnUrl = newUrl.toString();
    return returnUrl/* Private */;

  }

  /**
   * Conditions the URL for use by Wilt and checks for 
   * a valid database by default.
   */
  String _conditionUrl(String url) {

    if (db == null) {

      throw new WiltException('No database specified');
    }

    if (url == null) return '/';

    /* The first char of the URL should be a slash. */
    if (!url.startsWith('/')) {

      url = "/$url";

    }

    if (db != null) url = "/$db$url";

    return url;

  }

  /**
   * Basic method where only a URL and a method is passed.
   * Wilt applies no checks to this URL nor does it add the
   * database, the format of this is entirely up to the user.
   * 
   * This can be used for CouchDb functions that are not directly supported by Wilt,
   * e.g views, attachments and design documents.
   */
  Future<jsonobject.JsonObject> httpRequest(String url, {String method: "GET"}) {


    /* Perform the request */
    return _httpRequest(method, url);
  }

  /**
   * Performs an HTTP GET operation, the URL is conditioned and
   * the current database added.
   */
  Future<jsonobject.JsonObject> get(String url) {

    url = _conditionUrl(url);

    /* Perform the get */
    return _httpRequest('GET', url);


  }

  /**
   * Performs a HTTP HEAD operation, the URL is conditioned and
   * the current database added.
   */
  Future<jsonobject.JsonObject> head(String url) {

    url = _conditionUrl(url);

    /* Perform the head */
   return  _httpRequest(HEAD, url);

  }

  /**
   * Performs a HTTP POST operation,, the URL is conditioned and
   * the current database added.
   */
  Future<jsonobject.JsonObject> post(String url, String data, [Map headers]) {

    url = _conditionUrl(url);

    /* Perform the post */
    return _httpRequest('POST', url, data: data, headers: headers);

  }

  /**
   * Performs a HTTP PUT operation,, the URL is conditioned and
   * the current database added.
   */
  Future<jsonobject.JsonObject> put(String url, String data, [Map headers]) {

    url = _conditionUrl(url);

    /* Perform the put */
    return _httpRequest('PUT', url, data: data, headers: headers);

  }

  /**
   * Performs a HTTP DELETE operation,, the URL is conditioned and
   * the current database added.
   *
   */
  Future<jsonobject.JsonObject> delete(String url) {


    url = _conditionUrl(url);

    /* Perform the delete */
   return  _httpRequest('DELETE', url);

  }

  /**
   * Performs an HTTP GET operation for the supplied document id and
   * optional revision. If withAttachments is set the the body of
   * any attachments are also supplied, note this could make this 
   * a large transfer.
   */
  Future<jsonobject.JsonObject> getDocument(String id, [String rev = null, bool withAttachments = false])
      {

    if (id == null) {

      throw new WiltException('getDocument() must have a document id');
    }

    String url = id;
    if (rev != null) {

      url = _setURLParameter(url, 'rev', rev);
    }

    if (withAttachments) {

      url = _setURLParameter(url, 'attachments', 'true');
    }

    url = _conditionUrl(url);
   return  _httpRequest('GET_DOCUMENT', url);


  }


  /**
   * DELETE's the specified document. Must have a revision.
   */
  Future<jsonobject.JsonObject> deleteDocument(String id, String rev) {

    if ((id == null) || (rev == null)) {

      throw new WiltException(
          'deleteDocument() expects a document id and a revision.');
    }

    String url = id;
    url = _setURLParameter(url, 'rev', rev);

    url = _conditionUrl(url);
    return _httpRequest('DELETE_DOCUMENT', url);

  }


  /**
   * PUT's to the specified  document.
   * 
   * For an update the revision must be specified, this can be in the
   * document body as a _rev parameter or specified in the call in which
   * case this will be added to the document body.
   */
  Future<jsonobject.JsonObject> putDocument(String id, jsonobject.JsonObject document, [String rev =
      null]) {


    if ((id == null) || (document == null)) {

      throw new WiltException(
          'putDocument() expects a document id and a document body.');
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

      throw new WiltException(
          'putDocument() cannot stringify the document body, use putDocumentString');

    }

    String url = _conditionUrl(id);
   return  _httpRequest('PUT_DOCUMENT', url, data: jsonData);


  }

  /**
   * PUT's to the specified  document where the document is supplied as 
   * a JSON string. Must be used if '_id' and or '_rev' are needed.
   */
  Future<jsonobject.JsonObject> putDocumentString(String id, String document, [String rev = null]) {


    if ((id == null) || (document == null)) {

      throw new WiltException(
          'putDocumentString() expects a document id and a document body.');
    }

    /* Check for a revision */
    if (rev != null) id = "$id?rev=$rev";

    String url = _conditionUrl(id);
    return _httpRequest('PUT_DOCUMENT', url, data: document);



  }

  /**
   * POST's the specified document.
   * An optional path to the document can be specified.
   */
  Future<jsonobject.JsonObject> postDocument(jsonobject.JsonObject document, {String path: null}) {


    if (document == null) {

      throw new WiltException('postDocument() expects a document body.');
    }

    String url = "";
    if (path != null) url = "$url/$path";

    /* Set the content type for a post */
    Map headers = new Map<String, String>();
    headers["Content-Type"] = "application/json";

    String jsonData = null;
    try {

      jsonData = JSON.encode(document);

    } catch (e) {

      throw new WiltException(
          'postDocument() cannot stringify document body , use postDocumentString');
    }

    url = _conditionUrl(url);
    return _httpRequest('POST_DOCUMENT', url, data: jsonData, headers: headers);


  }

  /**
   * POST's to the specified  document where the document is supplied as 
   * a JSON string. Must be used if '_id' and or '_rev' are needed.
   */
  Future<jsonobject.JsonObject> postDocumentString(String document, {String path: null}) {


    if (document == null) {

      throw new WiltException('postDocumentString() expects a document body.');
    }

    String url = "";
    if (path != null) url = "$url/$path";

    /* Set the content type for a post */
    Map headers = new Map<String, String>();
    headers["Content-Type"] = "application/json";

    url = _conditionUrl(url);
    return _httpRequest('POST_DOCUMENT_STRING', url, data: document, headers: headers);


  }

  /**
   * Copies the source document to the destination document with an optional revision
   * NOTE this method uses the CouchDB COPY method which is not standard HTTP.
   */
  Future<jsonobject.JsonObject> copyDocument(String sourceId, String destinationId, [String rev = null])
      {

    if (sourceId == null) {

      throw new WiltException('copyDocument () expects a source id.');
    }

    if (destinationId == null) {

      throw new WiltException('copyDocument () expects a destination id.');
    }


    String url = sourceId;

    /* Create the special COPY header */
    Map headers = new Map<String, String>();
    String destination = destinationId;
    if (rev != null) destination = "$destinationId?rev=$rev";
    headers['Destination'] = destination;

    url = _conditionUrl(url);
    return _httpRequest('COPY_DOCUMENT', url, headers: headers);


  }

  /**
   * Get all documents.
   * The parameters should be self explanatory and are addative.
   * Refer to the CouchDb documentation for further explanation.
   */
  Future<jsonobject.JsonObject> getAllDocs({bool includeDocs: false, int limit: null, String startKey:
      null, String endKey: null, List<String> keys: null, bool descending: false}) {


    /* Validate the parameters */
    if ((limit != null) && (limit < 0)) {

      throw new WiltException('getAllDocs() must have a positive limit');

    }

    String url = ALLDOCS;

    /* Check the parameters and build the URL as needed */
    if (includeDocs) {

      url = _setURLParameter(url, 'include_docs', "true");

    }

    if (limit != null) {

      url = _setURLParameter(url, 'limit', limit.toString());

    }

    if (startKey != null) {

      String jsonStartkey = '"$startKey"';
      url = _setURLParameter(url, 'startkey', jsonStartkey);

    }

    if (endKey != null) {

      String jsonEndkey = '"$endKey"';
      url = _setURLParameter(url, 'endkey', jsonEndkey);

    }

    if (descending) {

      url = _setURLParameter(url, 'descending', descending.toString());

    }

    if (keys != null) {

      String keyString = JSON.encode(keys);
      url = _setURLParameter(url, 'keys', keyString);
    }

    url = _conditionUrl(url);
    return  _httpRequest('GET_ALLDOCS', url);

  }

  /**
   * Bulk insert
   * Bulk inserts a list of documents
   */
  Future<jsonobject.JsonObject> bulk(List<jsonobject.JsonObject> docs, [bool allOrNothing = false]) {


    /* Validate the parameters */
    if (docs == null) {

      throw new WiltException('bulk() must have a document list.');

    }

    String url = BULKDOCS;

    if (allOrNothing) {

      url = _setURLParameter(url, 'all_or_nothing', allOrNothing.toString());
    }

    /* Create the bulk insertion data structure */
    Map documentMap = new Map<String, List>();
    documentMap["docs"] = docs;
    String docString = null;
    try {

      docString = JSON.encode(documentMap);

    } catch (e) {

      throw new WiltException(
          'bulk() cannot stringify document list, use bulkString.');

    }

    /* Must set the content type for a post */
    Map headers = new Map<String, String>();
    headers["Content-Type"] = "application/json";

    url = _conditionUrl(url);
    return _httpRequest(BULK, url, data: docString, headers: headers);

  }

  /**
   * Bulk insert JSON string version.
   * Must be used if '_id' and or '_rev' are needed in ANY of the documents
   */
  Future<jsonobject.JsonObject> bulkString(String docs, [bool allOrNothing = false]) {


    /* Validate the parameters */
    if (docs == null) {

      throw new WiltException('bulkString() must have a document string.');

    }

    String url = BULKDOCS;

    if (allOrNothing) {

      url = _setURLParameter(url, 'all_or_nothing', allOrNothing.toString());
    }

    /* Must set the content type for a post */
    Map headers = new Map<String, String>();
    headers["Content-Type"] = "application/json";

    url = _conditionUrl(url);
    return _httpRequest(BULK_STRING, url, data: docs, headers: headers);

  }

  /**
   * Creates a database with the specified name.
   */
  Future<jsonobject.JsonObject> createDatabase(String name) {

    if ((name == null)) {

      throw new WiltException('createDatabase() expects a database name.');
    }

    /* The first char of the URL should be a slash. */
    String url = name;
    if (!url.startsWith('/')) {

      url = "/$url";

    }

    return _httpRequest(CREATE_DATABASE, url);

  }

  /**
   * Deletes the specified database
   */
  Future<jsonobject.JsonObject> deleteDatabase(String name) {

    if (name == null) {

      throw new WiltException('deleteDatabase() expects a database name.');
    }

    /* The first char of the URL should be a slash. */
    String url = name;
    if (!url.startsWith('/')) {

      url = "/$url";

    }

    /* Null the current database if we have deleted it */
    if (name == db) _db = null;

    return _httpRequest(DELETE_DATABASE, url);

  }

  /**
   * Get information about a database
   */
  Future<jsonobject.JsonObject> getDatabaseInfo([String dbName = null]) {

    String name;
    if (dbName != null) {

      name = dbName;

    } else {

      name = db;
    }

    String url = "/$name";

    return _httpRequest(DATABASE_INFO, url);

  }
  /**
   * Get current session information from CouchDB
   */
  Future<jsonobject.JsonObject> getSession() {

    String url = SESSION;

   return _httpRequest(GET_SESSION, url);

  }

  /**
   * Get current stats from CouchDB
   */
  Future<jsonobject.JsonObject> getStats() {

    String url = STATS;

    return _httpRequest(GET_STATS, url);

  }

  /**
   * Get all the databases from CouchDB
   */
  Future<jsonobject.JsonObject> getAllDbs() {

    String url = ALLDBS;

    return _httpRequest(GET_ALLDBS, url);

  }

  /**
   * Create an attachment on an existing document.
   * contentType is in the form of a mime type e.g. 'image/png'
   * If the document needs to be created as well as the attachment set the rev to ''
   */
  Future<jsonobject.JsonObject> createAttachment(String docId, String attachmentName, String rev, String
      contentType, String payload) {

    /**
    * Check all parameters are supplied
    */
    if (docId == null) {

      throw new WiltException('createAttachment() expects a document id.');
    }

    if (attachmentName == null) {

      throw new WiltException('createAttachment() expects an attachment name.');
    }

    if (rev == null) {

      throw new WiltException('createAttachment() expects a revision.');
    }

    if (contentType == null) {

      throw new WiltException('createAttachment() expects a content type.');
    }

    if (payload == null) {

      throw new WiltException('createAttachment() expects a payload.');
    }

    /**
     * Set the headers
     */
    Map headers = new Map<String, String>();
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
    return _httpRequest(CREATE_ATTACHMENT, url, data: payload, headers: headers);

  }

  /**
   * Update an attachment on an existing document.
   * contentType is in the form of a mime type e.g. 'image/png'
   */
  Future<jsonobject.JsonObject> updateAttachment(String docId, String attachmentName, String rev, String
      contentType, String payload) {

    /**
    * Check all parameters are supplied
    */
    if (docId == null) {

      throw new WiltException('updateAttachment() expects a document id.');
    }

    if (attachmentName == null) {

      throw new WiltException('updateAttachment() expects an attachment name.');
    }

    if (rev == null) {

      throw new WiltException('updateAttachment() expects a revision.');
    }

    if (contentType == null) {

      throw new WiltException('updateAttachment() expects a content type.');
    }

    if (payload == null) {

      throw new WiltException('updateAttachment() expects a payload.');
    }

    /**
     * Set the headers
     */
    Map headers = new Map<String, String>();
    headers["Content-Type"] = contentType;


    String url = "$docId/$attachmentName?rev=$rev";

    url = _conditionUrl(url);
    return _httpRequest(UPDATE_ATTACHMENT, url, data: payload, headers: headers);

  }

  /**
   * Delete an attachment
   */
  Future<jsonobject.JsonObject> deleteAttachment(String docId, String attachmentName, String rev) {

    if (docId == null) {

      throw new WiltException('deleteAttachment() expects a document id.');
    }

    if (attachmentName == null) {

      throw new WiltException('deleteAttachment() expects an attachment name.');
    }

    if (rev == null) {

      throw new WiltException('deleteAttachment() expects a revision.');
    }


    String url = "$docId/$attachmentName?rev=$rev";

    url = _conditionUrl(url);
    return _httpRequest(DELETE_ATTACHMENT, url);

  }

  /**
   * Get an attachment
   */
  Future<jsonobject.JsonObject> getAttachment(String docId, String attachmentName) {


    if (docId == null) {

      throw new WiltException('getAttachment() expects a document id.');
    }

    if (attachmentName == null) {

      throw new WiltException('getAttachment() expects an attachment name.');
    }


    String url = "$docId/$attachmentName";

    url = _conditionUrl(url);
   return  _httpRequest(GET_ATTACHMENT, url);

  }

  /**
   * Change notification start, see the WiltChangeNotification class for more details
   * 
   * If a database name is not supplied the currently selected database is used.
   */
  void startChangeNotification([WiltChangeNotificationParameters parameters =
      null, String databaseName = null]) {

    String name;
    if (databaseName == null) {

      name = db;

    } else {

      name = databaseName;
    }

    changeNotificationDbName = name;
    _changeNotifier = new _WiltChangeNotification(_host, _port, _scheme, _httpAdapter, name,
        parameters);
  }

  /**
   * Change notification stop, see the WiltChangeNotification class for more details
   * 
   * Note that this destroys the internal changeNotifier object which can only be 
   * reinstated by a call to startChangeNotification.
   */
  void stopChangeNotification() {

    _changeNotifier.stopNotifications();
    _changeNotifier = null;
    changeNotificationDbName = null;

  }

  /**
   * Change the parameter set for change notifications.
   * 
   * Note that database name, host, port and scheme are not changeable.
   */
  void updateChangeNotificationParameters(WiltChangeNotificationParameters
      parameters) {


    if (parameters == null) {

      throw new WiltException(
          'updateChangeNotificationParameters() expects a parameter set.');
    }

    if (_changeNotifier == null) {

      throw new WiltException(
          'updateChangeNotificationParameters() no change notifier.');
    }

    _changeNotifier.parameters = parameters;

  }

  /**
   * Pause change notifications
   */
  void pauseChangeNotifications() {

    _changeNotifier.pause = true;
    _changeNotifier.stopNotifications();

  }

  /**
   * Restart change notifications after a pause
   */
  void restartChangeNotifications() {

    _changeNotifier.pause = false;
    _changeNotifier.restartChangeNotifications();

  }

  /**
   * Authentication.
   * Updates the login credentials in Wilt that will be used for all further
   * requests to CouchDB. Both user name and password must be set, even if one
   * or the other is '' i.e empty. After logging in all communication with CouchDB
   * is made using the selected auithentication method.
   */
  void login(String user, String password) {


    if ((user == null) || (password == null)) {

      throw new WiltException(
          'Login() expects a non null user name and password');
    }

    _user = user;
    _password = password;
    authenticationType = AUTH_BASIC;

  }

  /**
   * Ask CouchDB to generate document Id's.
   * 
   */
  Future<jsonobject.JsonObject> generateIds([int amount = 10]) {

    if (amount < 1) {

      throw new WiltException('generateIds() expects a positive amount.');
    }

    String url = UUIDS;

    url = _setURLParameter(url, 'count', amount.toString());

    return _httpRequest(GENERATE_IDS, url);

  }


}
