import 'dart:developer';

import 'package:chatt_app/data/models/user_model.dart';
import 'package:chatt_app/data/services/base_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository extends BaseRepository{
  
 Future<UserModel> signUp({

  required String fullName,
  required String username,
  required String email,
  required String phoneNumber,
  required String password,

 }) async {
    try{
        final userCredential = await auth.createUserWithEmailAndPassword(
            email: email, 
            password: password
            );
            if(userCredential.user == null)
            {
                throw "Failed to creat a user";
            }

            // create a auser model and sav in db firestore

            final userModel = UserModel(
                uid: auth.currentUser!.uid, 
                username: username, 
                fullName: fullName, 
                email: email, 
                phoneNumber: phoneNumber, 

                );
    }
    catch(e) {
        log(e.toString());
    }
 }
}