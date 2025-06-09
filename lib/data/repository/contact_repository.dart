import 'package:chatt_app/data/services/base_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactRepository extends BaseRepository{
  String get currentUserId => FirebaseAuth.instance.currentUser?.uid ?? "";

  Future<bool> requestContactsPermission() async {
    return await FlutterContacts.requestPermission();
  }

  Future<List<Map<String, dynamic>>> getRegisteredContacts() async {
    try {
      
      // get the device contact with phone no.

      final contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: true,
      );

      // extract phone no. and normalize them

      final phoneNumbers = contacts
      .where((contact) => contact.phones.isNotEmpty)
    .map((contact) => {
      "name": contact.displayName,
      "phoneNumber": contact.phones.first.number.replaceAll(RegExp(r'[^\d+]'), ''),
      "photo": contact.photo,
    }).toList();

      // get all users from firestore

      // match contacts with registered users
    } catch (e) {
      
    }
  }
}