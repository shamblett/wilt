/*
 * Packge : Wilt
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 04/06/2013
 * Copyright :  S.Hamblett@OSCF
 *
 * Change notification parameters, defaults taken from the CouchDB API documents.
 * 
 */

part of wilt;

class WiltChangeNotificationParameters {
  /// Since
  ///
  /// Start the results from the change immediately after the given sequence update
  int _since = 0;
  int get since => _since;
  set since(int value) => _since = value;

  /// Descending
  ///
  /// Return the change results in descending sequence order (most recent change first)
  bool _descending = false;
  bool get descending => _descending;
  set descending(bool on) => _descending = on;

  /// Heartbeat
  ///
  /// Period in milliseconds between notification requests to CouchDB
  /// Be sensible with this, 1 second between requests is a good minimum.
  int _heartbeat = 2000;
  int get heartbeat => _heartbeat;
  set heartbeat(int period) => _heartbeat = period;

  /// Include documents
  ///
  /// Include the associated document with each result. If there are conflicts,
  /// only the winning revision is returned
  bool _includeDocs = false;
  bool get includeDocs => _includeDocs;
  set includeDocs(bool include) => _includeDocs = include;

  /// Include attachments
  ///
  /// Include any associated document attachments with each result.
  /// This will retrieve the body of the attachment in Base64 format
  /// as well as the stub data that is normally supplied.
  bool _includeAttachments = false;
  bool get includeAttachments => _includeAttachments;
  set includeAttachments(bool include) => _includeAttachments = include;
}
