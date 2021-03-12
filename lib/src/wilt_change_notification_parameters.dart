/*
 * Packge : Wilt
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 04/06/2013
 * Copyright :  S.Hamblett@OSCF
 * 
 */

part of wilt;

/// Change notification parameters class,  defaults taken from the CouchDB
/// API documents.
class WiltChangeNotificationParameters {
  /// Since
  ///
  /// Start the results from the change immediately after the given
  /// sequence update
  dynamic? since;

  /// Descending
  ///
  /// Return the change results in descending sequence order
  /// (most recent change first)
  bool descending;

  /// Heartbeat
  ///
  /// Period in milliseconds between notification requests to CouchDB
  /// Be sensible with this, 1 second between requests is a good minimum.
  int heartbeat;

  /// Include documents
  ///
  /// Include the associated document with each result. If there are conflicts,
  /// only the winning revision is returned
  bool includeDocs;

  /// Include attachments
  ///
  /// Include any associated document attachments with each result.
  /// This will retrieve the body of the attachment in Base64 format
  /// as well as the stub data that is normally supplied.
  bool includeAttachments;

  String? type;

  String? filter;
  String? doc_ids;

  WiltChangeNotificationParameters(
      {this.since,
        this.descending = false,
        this.heartbeat=2000,
        this.includeAttachments = false,
        this.includeDocs = false,
        this.type,
        this.filter,
        String? doc_ids,
      }){
    this.doc_ids="[\"$doc_ids\"]";
  }
}
