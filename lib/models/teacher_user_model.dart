class TeacherUserModel {
  Data data;
  Meta meta;

  TeacherUserModel({this.data, this.meta});

  TeacherUserModel.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
    meta = Meta.fromJson(json['meta']);
  }
}

class Data {
  int id;
  String name;
  String email;
  Teacher teacher;

  Data({this.id, this.name, this.email, this.teacher});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    teacher = Teacher.fromJson(json['teacher']);
  }
}

class Teacher {
  String nip;
  String type;
  String image;
  String identityNumber;

  Teacher({this.nip, this.type, this.image, this.identityNumber});

  Teacher.fromJson(Map<String, dynamic> json) {
    nip = json['nip'];
    type = json['type'];
    image = json['image'];
    identityNumber = json['identity_number'];
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
