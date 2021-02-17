import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movitm/assets/api_url.dart';
import 'package:movitm/logic/bloc/home_screen/home_screen_bloc.dart';
import 'package:movitm/logic/model/movie_model.dart';
import 'package:movitm/logic/movie_response.dart';
import 'package:movitm/screens/view_all_screen.dart';
import 'package:movitm/tools/movie_poster_widget.dart';
import 'package:provider/provider.dart';

import 'homeScreen/label_manager_widget.dart';
import 'homeScreen/movie_section.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var a = TimeOfDay.now();
    var message;
    if (a.hour >= 5 && a.hour < 12) {
      message = 'Morning';
    } else if (a.hour >= 12 && a.hour < 16) {
      message = 'Afternoon';
    } else if (a.hour >= 17 && a.hour < 21) {
      message = 'Evening';
    } else {
      message = 'Night';
    }
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final movies = Provider.of<HomeScreenMovieContent>(context);
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: movies == null
              ? Text('')
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Good $message',
                          style: TextStyle(
                            fontSize: width * 0.17,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'Upcoming Movies',
                          style: TextStyle(
                            fontSize: width * 0.07,
                            color: Colors.blueGrey,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
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
                                movies?.upcomingMovies?.movieList?.length,
                                (index) => Padding(
                                      padding: const EdgeInsets.only(
                                        top: 8.0,
                                        right: 10.0,
                                        bottom: 8.0,
                                      ),
                                      child: UpcomingMoviePosterWidget(
                                        movie: movies
                                            .upcomingMovies.movieList[index],
                                      ),
                                    )),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        LabelManagerWidget(
                          movieType: movies.streamingNow,
                          index: 1,
                        ),
                        SizedBox(height: 10.0),
                        MovieSection(
                          movies: movies?.streamingNow?.movieList,
                        ),
                        SizedBox(height: 20.0),
                        LabelManagerWidget(
                          movieType: movies.topRated,
                          index: 2,
                        ),
                        SizedBox(height: 10.0),
                        MovieSection(
                          movies: movies?.topRated?.movieList,
                        ),
                        SizedBox(height: 20.0),
                        LabelManagerWidget(
                          movieType: movies.popular,
                          index: 3,
                        ),
                        SizedBox(height: 10.0),
                        MovieSection(
                          movies: movies?.popular?.movieList,
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class UpcomingMoviePosterWidget extends StatelessWidget {
  final MovieModel movie;

  const UpcomingMoviePosterWidget({Key key, @required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.8,
      decoration: BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(ApiURL.posterBaseURL + movie.backdropPath),
        ),
      ),
    );
  }
}