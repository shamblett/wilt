/*
 * Packge : Wilt
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 04/06/2013
 * Copyright :  S.Hamblett@OSCF
 */

import '../lib/wilt.dart';

/* Global configuration, please edit */

/* CouchDB server */
String hostName = "localhost";
String port = "5984";
String scheme = "http://"; 

/* Database to use for testing */
String databaseName = 'wilttest';

/**
 *  Authentication, set as you wish, note leaving userName and password null 
 *  implies no authentication, i.e admin party, if set Basic authentication is 
 *  used.
 */

String userName = null;
String userPassword = null;

