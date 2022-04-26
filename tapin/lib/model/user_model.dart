class UserModel {
  String? uid;
  String? email;

  UserModel({this.uid, this.email});

  //data from server

  factory UserModel.fromMap(Map) {
    return UserModel(
      uid: Map['uid'],
      email: Map['email'],
    );
  }

  //data to server

  Map<String, dynamic> tomap() {
    return {
      'uid': uid,
      'email': email,
    };
  }
}
