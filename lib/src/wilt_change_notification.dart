/*
 * Packge : Wilt
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 07/01/2014
 * Copyright :  S.Hamblett@OSCF
 *
 * Change notification control class
 * 
 * This class when constructed initiates change notification processing with either
 * a default set of change notification parameters or one supplied by the client.
 * When destroyed, change notification ceases.
 * 
 * 
 * The resulting notifications are turned into notification events and streamed to
 * the notification consumer. as a stream of WiltChangeNotificationEvent objects, see 
 * this class for further details.
 * 
 * CouchDb is initialized to supply the change notification stream in 'normal' mode, hence
 * this class requests the updates manually on a timed basis dependent on the heartberat period.
 * 
 * Note that as form CouchDB 1.6.1 you must auth as an administrator with CouchDb
 * to allow notificatons to work, if you do not supply auth credentials before 
 * starting notifications an exception is raised. 
 */

part of wilt;

class _WiltChangeNotification {
  _WiltChangeNotification(
      this._host, this._port, this._scheme, this._httpAdapter,
      [this._dbName, this._parameters]) {
    if (_parameters == null) {
      _parameters = new WiltChangeNotificationParameters();
    }

    _sequence = _parameters.since;

    /**
     * Start the heartbeat timer
     */
    final Duration heartbeat =
        new Duration(milliseconds: _parameters.heartbeat);
    _timer = new Timer.periodic(heartbeat, _requestChanges);

    /**
     * Start change notifications
     */
    _requestChanges(_timer);
  }

  /// Parameters set
  WiltChangeNotificationParameters _parameters = null;
  WiltChangeNotificationParameters get parameters => _parameters;
  set parameters(WiltChangeNotificationParameters parameters) =>
      _parameters = parameters;

  /// Database name
  String _dbName = null;

  /// Host name
  String _host = null;

  /// Port number
  String _port = null;

  /// HTTP scheme
  String _scheme = null;

  /// Timer
  Timer _timer = null;

  /// Since sequence number
  int _sequence = 0;

  /// Paused indicator
  bool _paused = false;
  bool get pause => _paused;
  set pause(bool flag) => _paused = flag;

  WiltHTTPAdapter _httpAdapter = null;

  /// Change notification stream controller
  ///
  /// Populated with WiltChangeNotificationEvent events
  final StreamController _changeNotification = new StreamController.broadcast();
  StreamController get changeNotification => _changeNotification;

  /// Request the change notifications
  void _requestChanges(Timer timer) {
    /**
     * If paused return
     */
    if (_paused) return;

    /**
     * Create the URL from the parameters
     */
    final String sequence = _sequence.toString();
    final String path = "$_dbName/_changes?" +
        "&since=$sequence" +
        "&descending=${_parameters.descending}" +
        "&include_docs=${_parameters.includeDocs}" +
        "&attachments=${_parameters.includeAttachments}";

    final String url = "$_scheme$_host:${_port.toString()}/$path";

    /**
     * Open the request
     */
    try {
      _httpAdapter.getString(url)
        ..then((result) {
          /**
        * Process the change notification
        */
          try {
            final Map dbChange = json.decode(result);
            processDbChange(dbChange);
          } catch (e) {
            /**
          * Recoverable error, send the client an error event
          */
            print(
                "WiltChangeNotification::MonitorChanges json decode fail ${e.toString()}");
            final WiltChangeNotificationEvent notification =
                new WiltChangeNotificationEvent.decodeError(
                    result, e.toString());

            _changeNotification.add(notification);
          }
        });
    } catch (e) {
      /**
       * Unrecoverable error, send the client an abort event
       */
      print(
          "WiltChangeNotification::MonitorChanges unable to contact CouchDB Error is ${e.toString()}");
      final WiltChangeNotificationEvent notification =
          new WiltChangeNotificationEvent.abort(e.toString());

      _changeNotification.add(notification);
    }
  }

  /// Database change updates
  void processDbChange(Map change) {
    /**
     * Check for an error response
     */
    if (change.containsKey('error')) {
      final WiltChangeNotificationEvent notification =
          new WiltChangeNotificationEvent.couchDbError(
              change['error'], change['reason']);

      _changeNotification.add(notification);

      return;
    }

    /**
     * Update the last sequence number
     */
    _sequence = change['last_seq'];

    /**
     * Process the result list
     */
    final List results = change['results'];
    if (results.isEmpty) {
      final WiltChangeNotificationEvent notification =
          new WiltChangeNotificationEvent.sequence(_sequence);

      _changeNotification.add(notification);

      return;
    }

    results.forEach((Map result) {
      final Map changes = result['changes'][0];

      /**
       * Check for delete or update
       */
      if (result.containsKey('deleted')) {
        final WiltChangeNotificationEvent notification =
            new WiltChangeNotificationEvent.delete(
                result['id'], changes['rev'], result['seq']);

        _changeNotification.add(notification);
      } else {
        jsonobject.JsonObjectLite document = null;
        if (result.containsKey('doc')) {
          document = new jsonobject.JsonObjectLite.fromMap(result['doc']);
        }
        final WiltChangeNotificationEvent notification =
            new WiltChangeNotificationEvent.update(
                result['id'], changes['rev'], result['seq'], document);

        _changeNotification.add(notification);
      }
    });
  }

  /// Stop change notifications
  void stopNotifications() {
    _timer.cancel();
  }

  /// Restart change notifications
  void restartChangeNotifications() {
    /**
     * Start the heartbeat timer
     */
    final Duration heartbeat =
        new Duration(milliseconds: _parameters.heartbeat);
    _timer = new Timer.periodic(heartbeat, _requestChanges);

    /**
     * Start change notifications
     */
    _requestChanges(_timer);
  }
}
