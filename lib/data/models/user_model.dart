import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel {
  final String uid;
  final String username;
  final String fullName;
  final String email;
  final String phoneNumber;

  final bool isOnline;
  final Timestamp lastseen;
  final Timestamp createdAt;
  final String? fmcToken;
  final List<String> blockedUsers;

  UserModel({
    required this.uid,
    required this.username,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    this.isOnline = false,
    Timestamp? lastseen,
    Timestamp? createdAt,
    this.fmcToken,
    this.blockedUsers = const [],
  })  : lastseen = lastseen ?? Timestamp.now(),
        createdAt = createdAt ?? Timestamp.now();

  UserModel copyWith({
    String? uid,
    String? username,
    String? fullName,
    String? email,
    String? phoneNumber,
    bool? isOnline,
    Timestamp? lastseen,
    Timestamp? createdAt,
    String? fmcToken,
    List<String>? blockedUsers,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isOnline: isOnline ?? this.isOnline,
      lastseen: lastseen ?? this.lastseen,
      createdAt: createdAt ?? this.createdAt,
      fmcToken: fmcToken ?? this.fmcToken,
      blockedUsers: blockedUsers ?? List.from(this.blockedUsers),
    );
  }

  factory UserModel.fromFirestore(DocumentSnapshot doc)
  {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id, 
      username: data["username"] ?? "", 
      fullName: data["fullName"] ?? "", 
      email: data["email"] ?? "", 
      phoneNumber: data["phoneNumber"] ?? "", 
      fmcToken: data["fmcToken"],
      lastseen: data["lastSeen"]?? TimeOfDay.now(),
      createdAt: data["createdAt"]?? Timestamp.now(),
      blockedUsers: List<String>.from(data["blockedUsers"]),
      );
  }

  Map<String, dynamic> toMap () {
    return {
      'username': username,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'isOnline': isOnline,
      'lastSeen': lastseen,
      'createdAt': createdAt,
      'blockedUsers': blockedUsers,
      'fmcToken': fmcToken,
    };
  }
}
