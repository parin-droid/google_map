class UserModel {
  int? id;
  Null? firebaseId;
  Null? fcmToken;
  String? name;
  String? email;
  String? password;
  String? type;
  String? createdAt;
  Null? updatedAt;

  UserModel(
      {this.id,
      this.firebaseId,
      this.fcmToken,
      this.name,
      this.email,
      this.password,
      this.type,
      this.createdAt,
      this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firebaseId = json['firebase_id'];
    fcmToken = json['fcm_token'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firebase_id'] = this.firebaseId;
    data['fcm_token'] = this.fcmToken;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
