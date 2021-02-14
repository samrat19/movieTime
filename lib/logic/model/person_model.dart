class PersonModel {
  String biography;
  String birthday;
  int id;
  String name;
  String placeOfBirth;
  double popularity;
  String profilePath;

  PersonModel(
      {this.biography,
        this.birthday,
        this.id,
        this.name,
        this.placeOfBirth,
        this.popularity,
        this.profilePath,
      });

  PersonModel.fromJson(Map<String, dynamic> json) {
    biography = json['biography'];
    birthday = json['birthday'];
    id = json['id'];
    name = json['name'];
    placeOfBirth = json['place_of_birth'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
  }
}