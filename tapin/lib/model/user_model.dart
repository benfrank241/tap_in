class UserModel {
  String? uid;
  String? email;
  String? username;

  UserModel({this.uid, this.email, this.username});

  //data from server

  factory UserModel.fromMap(Map) {
    return UserModel(
      uid: Map['uid'],
      email: Map['email'],
      username: Map['username'],
    );
  }

  //data to server

  Map<String, dynamic> tomap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
    };
  }
}
