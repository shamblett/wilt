# Wilt - a browser based CouchDB client library

## Introduction

Wilt is based on the lightweight SAG PHP CouchDB library [available here](http://www.saggingcouch.com/).
Users of this library should recognise the structure of Wilt easily.  

Wilt implements the document/database storage and manipulation interfaces of SAG along with
the utility functions such as get session information etc. It does not directly implement the
manipulation of design documents and attachments through the API, clients however can manipulate these
items by constructing their own URL's and using the basic httpRequest method.

Asynchronicity through the HTTP adapter is provided by the use of client supplied completion callbacks
which allow the client to inspect the result f a Wilt method call and process accordingly.

Authentication is provided using the Basic HTML method, cookie authentication is not
supported, see the CouchDB_and CORS.txt document in the doc directory for more details here.

Wilt is a fully functional standalone library, however it is envisaged that higher level client
specific application layers will be wrapped around Wilt to add specific CouchDB response parsing as
Wilt returns JSON Objects(or strings) to the client. It has no knowledge of correct/incorrect responses
such as conflict errors for instance, i.e it has no real CouchDB intelligence other than supplying success
or error responses from its HTTP interface adapter.

Please read the STARTHERE.txt document in the docs directory for more detailed information.

## Examples

Numerous examples of Wilt usage are coded as tests  in the test suite under the test directory.
Specifically tests wilt_test_2 and wilt_test_3 show how database/document manipulation 
is performed.

## Contact

Wilt is hosted [here](https://github.com/shamblett/wilt).
Please use github to raise issues, any other queries you can direct to me
at <steve.hamblett@linux.com>

