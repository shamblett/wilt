# Wilt - both a browser and server based CouchDB client library

Wilt is based on the lightweight SAG PHP CouchDB library [available here](http://www.saggingcouch.com/).
Users of this library should recognise the structure of Wilt easily. A common processing body is 
specialised by the use of browser(dart:html) or server(dart:io) HTTP adapters to allow operation in the
browser or the server.  

Wilt implements the document/attachment/database storage and manipulation interfaces of SAG along with
the utility functions such as get session information etc. It does not directly implement the
manipulation of design documents, clients however can manipulate these items by constructing their 
own URL's and using the basic httpRequest method.

Authentication is provided using the Basic HTML method, cookie authentication is not
supported.

Wilt is a fully functional standalone library, however it is envisaged that higher level client
specific application layers will be wrapped around Wilt to add specific CouchDB response parsing as
Wilt returns JSON Objects(or strings) to the client. It has no knowledge of correct/incorrect responses
such as conflict errors for instance, i.e it has no real CouchDB intelligence other than supplying success
or error responses from its HTTP interface adapter.

Note that the Wilt methods that previously returned Json Objects(JsonObjectLite) now return the dynamic type,
this is a JsonObjectLite and can be used as such. This change was necessitated as part of the
Dart 2.0 updates.
