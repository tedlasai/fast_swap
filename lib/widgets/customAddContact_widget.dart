import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class CustomAddContactWidget extends StatefulWidget {
  final String _email;
  final String _displayName;
  final String _phoneNumber;

  CustomAddContactWidget({Key key, email, phoneNumber, @required displayName})
      :assert(displayName != null),
        _email = email,
        _phoneNumber = phoneNumber,
        _displayName = displayName,
        super(key: key);

  State<CustomAddContactWidget> createState() => _CustomAddContactState();
}

class _CustomAddContactState extends State<CustomAddContactWidget> {
  String email;
  String displayName;
  String phoneNumber;

  @override
  void initState() {
    super.initState();
    email = widget._email;
    displayName = widget._displayName;
    phoneNumber = widget._phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      icon: Icon(Icons.person_add),
      onPressed: () {
        _addContact();
      },
      label: Text('Add Contact', style: TextStyle(color: Colors.white)),
      color: Colors.blueAccent,
    );
  }

  _addContact() async {
    Contact newContact = Contact();
    newContact.displayName = displayName;
    if(email != null) newContact.emails = [Item(label: "home", value: email)];
    if(phoneNumber != null) newContact.phones = [Item(label: "home", value: phoneNumber)];
    await ContactsService.addContact(newContact);
  }
}
