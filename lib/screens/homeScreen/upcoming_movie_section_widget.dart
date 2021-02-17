import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movitm/logic/model/movie_model.dart';
import 'upcoming_movie_poster_widget.dart';

class UpcomingMovieSectionWidget extends StatelessWidget {


  final List<MovieModel>  movies;

  const UpcomingMovieSectionWidget({Key key, @required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;

    return Container(
      foregroundDecoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Colors.grey.withOpacity(0.4),
            Colors.white,
          ],
          begin: Alignment(0, -1),
          end: Alignment(0, 1),
        ),
      ),
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 16 / 9,
          height: height * 0.25,
          enableInfiniteScroll: false,
          initialPage: 0,
          autoPlay: true,
          pauseAutoPlayOnTouch: true,
          // enlargeCenterPage: true,
        ),
        items: List.generate(
          movies.length,
              (index) => Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              right: 10.0,
              bottom: 8.0,
            ),
            child: UpcomingMoviePosterWidget(
              movie: movies[index],
            ),
          ),
        ),
      ),
    );
  }
}
