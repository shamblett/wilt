/*
 * Package : Wilt
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 04/06/2013
 * Copyright :  S.Hamblett@OSCF
 */

/* Global configuration, please edit */

/* Test duration */
final int TEST_DURATION = 500; // ms

/* CouchDB server */
String hostName = "proxy.dicerati.com";
String port = "8080";
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

