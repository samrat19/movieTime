import 'package:movitm/logic/model/person/person_image_model.dart';
import 'package:movitm/logic/model/person/person_link_model.dart';
import 'package:movitm/logic/model/person/person_movie_model.dart';

class PersonDetailsManager {
  PersonMovieModel movies;
  PersonImageModel images;
  PersonLinkModel links;

  PersonDetailsManager({
    this.movies,
    this.images,
    this.links,
  });
}
