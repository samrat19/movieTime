import 'package:movitm/logic/model/person/person_image_model.dart';
import 'package:movitm/logic/model/person/person_link_model.dart';
import 'package:movitm/logic/model/person/person_movie_model.dart';
import 'package:movitm/logic/model/person_model.dart';

class PersonDetailsManager {
  PersonMovieModel movies;
  PersonImageModel images;
  PersonLinkModel links;
  PersonModel person;

  PersonDetailsManager({
    this.movies,
    this.images,
    this.links,
    this.person,
  });
}
