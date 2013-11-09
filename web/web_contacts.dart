import 'dart:html';
import 'dart:convert';
import 'package:ex8/contacts.dart';
import 'package:polymer/polymer.dart';

@CustomTag('web-contacts')
class WebContacts extends PolymerElement {
  @published List<Contact> contacts;

  WebContacts.created() : super.created();

  add(Event e, var detail, Node target) {
    InputElement name = shadowRoot.querySelector("#name");
    InputElement email = shadowRoot.querySelector("#email");
    InputElement phone = shadowRoot.querySelector("#phone");
    LabelElement message = shadowRoot.querySelector("#message");
    var error = false;
    message.text = '';
    if (name.value.trim() == '') {
      message.text = 'name is mandatory; ${message.text}';
      error = true;
    }
    if (email.value.trim() == '') {
      message.text = 'email is mandatory; ${message.text}';
      error = true;
    }
    if (!error) {
      var contact = new Contact(name.value, email.value, phone.value);
      contacts.add(contact);
      save();
    }
  }

  List<Map<String, Object>> toJson() {
    var contactList = new List<Map<String, Object>>();
    for (Contact contact in contacts) {
      contactList.add(contact.toJson());
    }
    return contactList;
  }

  save() {
    window.localStorage['ex8'] = JSON.encode(toJson());
  }
}