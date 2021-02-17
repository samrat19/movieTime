import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movitm/logic/bloc/home_screen/home_screen_bloc.dart';
import 'package:movitm/screens/homeScreen/upcoming_movie_section_widget.dart';
import 'package:provider/provider.dart';
import 'label_manager_widget.dart';
import 'movie_section_widget.dart';

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
    Size size = MediaQuery.of(context).size;
    final movies = Provider.of<HomeScreenMovieContent>(context);
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
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
                      fontSize: size.width * 0.17,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Upcoming Movies',
                    style: TextStyle(
                      fontSize: size.width * 0.07,
                      color: Colors.blueGrey,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  UpcomingMovieSectionWidget(
                    movies: movies?.upcomingMovies?.movieList,
                  ),
                  SizedBox(height: 20.0),
                  LabelManagerWidget(
                    movieType: movies.streamingNow,
                    index: 1,
                  ),
                  SizedBox(height: 10.0),
                  MovieSectionWidget(
                    movies: movies?.streamingNow?.movieList,
                  ),
                  SizedBox(height: 20.0),
                  LabelManagerWidget(
                    movieType: movies.topRated,
                    index: 2,
                  ),
                  SizedBox(height: 10.0),
                  MovieSectionWidget(
                    movies: movies?.topRated?.movieList,
                  ),
                  SizedBox(height: 20.0),
                  LabelManagerWidget(
                    movieType: movies.popular,
                    index: 3,
                  ),
                  SizedBox(height: 10.0),
                  MovieSectionWidget(
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