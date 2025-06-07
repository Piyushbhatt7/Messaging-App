import 'package:chatt_app/data/models/user_model.dart';
import 'package:chatt_app/data/services/base_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository extends BaseRepository{
  
 Future<UserModel> signup({

  required String fullName,
  required String userName,
  required String email,
  required String phoneNumber,

 }) async {
    try{
        final userCredential = await 
    }
    catch(e) {

    }
 }
}