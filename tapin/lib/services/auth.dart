import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_model.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  UserModel? _userFromFirebaseUser(User? user){
    return user != null ? UserModel(uid: user.uid) : null;
  }

  // Stream<UserModel> get user{
  //   return auth.authStateChanges().map(_userFromFirebaseUser);
  // }


}