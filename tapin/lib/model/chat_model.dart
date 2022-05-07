class chatModel {
  String? message;
  String? sendby;
  chatModel({
    this.message,
    this.sendby,
  });

  //data from server

  factory chatModel.fromMap(Map) {
    return chatModel(
      message: Map['message'],
      sendby: Map['sendby'],
    );
  }

  //data to server

  Map<String, dynamic> tomap() {
    return {
      'message': message,
      'sendby': sendby,
    };
  }
}
