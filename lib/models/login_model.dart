class LoginModel {
  Data data;
  String token;
  Meta meta;

  LoginModel({this.data, this.token, this.meta});

  LoginModel.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
    token = json['token'];
    meta = Meta.fromJson(json['meta']);
  }
}

class Data {
  int id;
  String name;
  String email;
  String role;

  Data({this.id, this.name, this.email, this.role});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
  }
}

class Meta {
  bool success;
  String message;

  Meta({this.success, this.message});

  Meta.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }
}
