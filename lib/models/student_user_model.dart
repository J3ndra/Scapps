class StudentUserModel {
  Data data;
  Meta meta;

  StudentUserModel({this.data, this.meta});

  StudentUserModel.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
    meta = Meta.fromJson(json['meta']);
  }
}

class Data {
  int id;
  String name;
  String email;
  Student student;

  Data({this.id, this.name, this.email, this.student});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    student = Student.fromJson(json['student']);
  }
}

class Student {
  String nis;
  String nisn;
  String image;

  Student({this.nis, this.nisn, this.image});

  Student.fromJson(Map<String, dynamic> json) {
    nis = json['nis'];
    nisn = json['nisn'];
    image = json['image'];
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
