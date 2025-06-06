import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {

  final String uid;
  final String username;
  final String fullName;
  final String email;
  final String phoneNumber;

  final bool isOnline;
  final Timestamp lastseen;
  final Timestamp createdAt;

}