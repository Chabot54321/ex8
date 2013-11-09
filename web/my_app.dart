import 'dart:html';
import 'dart:convert';
import 'package:ex8/contacts.dart';
import 'package:polymer/polymer.dart';

@CustomTag('my-app')
class MyApp extends PolymerElement {
  var contacts = toObservable(new List<Contact>());

  MyApp.created() : super.created() {
    load();
  }

  init() {
    var contact1 = new Contact('Joe', 'joe@hotmail.com','418-580-7777');
    var contact2 = new Contact('Billy', 'Billy@hotmail.com','418-555-5555');
    var contact3 = new Contact('Books', 'Livre@hotmail.com','418-666-6666');
    Model.one.contacts..add(contact1)..add(contact2)..add(contact3);
  }

  fromJson(List<Map<String, Object>> contactist) {
    if (!contacts.isEmpty) {
      throw new Exception('links are not empty');
    }
    for (Map<String, Object> linkMap in contactist) {
      Contact link = new Contact.fromJson(linkMap);
      contacts.add(link);
    }
  }

  load() {
    String json = window.localStorage['ex8'];
    if (json == null) {
      init();
    } else {
      fromJson(JSON.decode(json));
    }
  }
}