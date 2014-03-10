/*
 * Package : Wilt
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 04/06/2013
 * Copyright :  S.Hamblett@OSCF
 */

/* Global configuration, please edit */

/* CouchDB server */
final String hostName = "proxy.dicerati.com";
final String port = "8080/couch-dart";
final String scheme = "http://"; 

/* Databases to use for testing */
final String databaseName = 'wilttest';
final String databaseNameFutures = 'wilttest_future';

/**
 *  Authentication, set as you wish, note leaving userName and password null 
 *  implies no authentication, i.e admin party, if set Basic authentication is 
 *  used.
 */

final String userName = 'xxxxx';
final String userPassword = 'xxxxx';

