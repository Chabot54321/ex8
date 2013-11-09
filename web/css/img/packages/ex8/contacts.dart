library contacts;

class Contact implements Comparable {
  String name;
  String email;
  String phone;
 
  Contact(this.name, this.email,this.phone) { 
  }

  
  Contact.fromJson(Map<String, Object> contactMap) {
    name = contactMap['name'];
    email = contactMap['email'];
    phone = contactMap['phone'];
  }

  Map<String, Object> toJson() {
    var contactMap = new Map<String, Object>();
    contactMap['name'] = name;
    contactMap['email'] = email;
    contactMap['phone'] = phone;
    return contactMap;
  }

  String toString() {
    return '{name: ${name},email: ${email},phone: ${phone}, }';
  }


  int compareTo(Contact contact) {
    if (name != null && contact.name != null) {
      return name.compareTo(contact.name);
    } else {
      throw new Exception('Vous devez présenter le nom dun contact');
    }
  }
}

class Contacts {
  var _list = new List<Contact>();

  Iterator<Contact> get iterator => _list.iterator;
  bool get isEmpty => _list.isEmpty;

  List<Contact> get internalList => _list;
  set internalList(List<Contact> observableList) => _list = observableList;

  bool add(Contact newContact) {
    if (newContact == null) {
      throw new Exception('a new contact must be present');
    }
    for (Contact contact in this) {
      if (newContact.name == contact.name) return false;
    }
    _list.add(newContact);
    return true;
  }

  Contact find(String name) {
    for (Contact contact in _list) {
      if (contact.name == name) return contact;
    }
    return null;
  }

  bool remove(Contact contact) {
    return _list.remove(contact);
  }

  sort() {
    _list.sort();
  }
}

class Model {
  var contacts = new Contacts();

  // singleton design pattern: http://en.wikipedia.org/wiki/Singleton_pattern
  // Comme polymer_links_s06
  
  static Model model;
  Model.private();
  static Model get one {
    if (model == null) {
      model = new Model.private();
    }
    return model;
  }
  // singleton

  init() {
    var contact1 = new Contact('Joe', 'joe@hotmail.com','418-580-7777');
    var contact2 = new Contact('Billy', 'Billy@hotmail.com','418-555-5555');
    var contact3 = new Contact('Books', 'Livre@hotmail.com','418-666-6666');
    Model.one.contacts..add(contact1)..add(contact2)..add(contact3);
  }

  List<Map<String, Object>> toJson() {
    var contactList = new List<Map<String, Object>>();
    for (Contact contact in contacts) {
      contactList.add(contact.toJson());
    }
    return contactList;
  }

  fromJson(List<Map<String, Object>> contactList) {
    if (!contacts.isEmpty) {
      throw new Exception('contacts are not empty');
    }
    for (Map<String, Object> contactMap in contactList) {
      Contact contact = new Contact.fromJson(contactMap);
      contacts.add(contact);
    }
  }
}
