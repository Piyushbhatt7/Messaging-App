import 'dart:developer';
import 'package:chatt_app/data/models/user_model.dart';
import 'package:chatt_app/data/services/base_repository.dart';

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

            final user = UserModel(
                uid: userCredential.user!.uid, 
                username: username, 
                fullName: fullName, 
                email: email, 
                phoneNumber: phoneNumber, 
            );

            await saveUserData(user);  
            return user; 
    }
    catch(e) {
        log(e.toString());
        rethrow;
    }
 }

 Future<UserModel> signIn({

  required String email,
  required String password,

 }) async {
    try{
        final userCredential = await auth.signInWithEmailAndPassword(
            email: email, 
            password: password
            );
            if(userCredential.user == null)
            {
                throw "User not found";
            }
 
    }
    catch(e) {
        log(e.toString());
        rethrow;
    }
 }

 Future<void> saveUserData(UserModel user) async{

    try {
      await firestore.collection("users").doc(user.uid).set(user.toMap());
    } catch (e) {
      throw "Failed to save user data"; 
    }
 }


  Future<UserModel> getUserData(String uid) async{

    try {
      final doc = await firestore.collection("users").doc(uid).get();

      if(!doc.exists)
      {
        throw "User data not found";
      }
      return UserModel.fromFirestore(doc);
    } catch (e) {
      throw "Failed to save user data"; 
    }
 }
}
