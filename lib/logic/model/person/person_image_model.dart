class PersonImageModel {
  int id;
  List<Profiles> profiles = [];

  PersonImageModel({this.id, this.profiles});

  PersonImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['profiles'] != null) {
      json['profiles'].forEach((v) {
        profiles.add(new Profiles.fromJson(v));
      });
    }
  }
}

class Profiles {
  String filePath;

  Profiles(
      {this.filePath,});

  Profiles.fromJson(Map<String, dynamic> json) {
    filePath = json['file_path'];
  }
}