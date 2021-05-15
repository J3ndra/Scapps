class LogoutModel {
  Meta meta;

  LogoutModel({this.meta});

  LogoutModel.fromJson(Map<String, dynamic> json) {
    meta = Meta.fromJson(json['meta']);
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
