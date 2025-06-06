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
  final String fmcToken;
  final List<String> blockedUsers;

  UserModel({
    required this.uid,
    required this.username,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.isOnline,
    required this.lastseen,
    required this.createdAt,
    required this.fmcToken,
    required this.blockedUsers,
  });
}
