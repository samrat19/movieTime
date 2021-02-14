import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movitm/assets/api_url.dart';
import 'package:movitm/logic/bloc/home_screen_bloc.dart';
import 'package:movitm/logic/model/movie_model.dart';
import 'package:movitm/screens/view_all_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final movies = Provider.of<HomeScreenMovieContent>(context);
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'MovieTM',
            style: TextStyle(fontSize: 30.0),
          ),
        ),
        body: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo[900], Colors.black],
              begin: Alignment(0, 1.5),
              end: Alignment(0, -1),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                children: [
                  SizedBox(height: 20.0),
                  CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 16 / 9,
                      height: height * 0.2,
                      enableInfiniteScroll: false,
                      initialPage: 0,
                      autoPlay: true,
                      pauseAutoPlayOnTouch: true,
                      // enlargeCenterPage: true,
                    ),
                    items: List.generate(
                         movies.upcomingMovies?.length,
                        (index) => Padding(
                              padding: const EdgeInsets.only(
                                top: 8.0,
                                right: 10.0,
                                bottom: 8.0,
                              ),
                              child: UpcomingMoviePosterWidget(
                                movie: movies.upcomingMovies[index],
                              ),
                            )),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Streaming Now',
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ViewAllScreen(
                              segment: ' Streaming Now',
                            ),
                          ),
                        ),
                        child: Text(
                          'View All',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: height * 0.3,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.streamingNow?.length,
                      itemBuilder: (_, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MoviePosterWidget(
                          movie: movies.streamingNow[index],
                        ),
                      ),
                      separatorBuilder: (_, index) => SizedBox(
                        width: 2.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Top Rated',
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ViewAllScreen(
                              segment: ' Top Rated',
                            ),
                          ),
                        ),
                        child: Text(
                          'View All',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: height * 0.3,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.topRated?.length,
                      itemBuilder: (_, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MoviePosterWidget(
                          movie: movies.topRated[index],
                        ),
                      ),
                      separatorBuilder: (_, index) => SizedBox(
                        width: 2.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Other Popular',
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ViewAllScreen(
                              segment: ' Popular Movies',
                            ),
                          ),
                        ),
                        child: Text(
                          'View All',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: height * 0.3,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.popular?.length,
                      itemBuilder: (_, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MoviePosterWidget(
                          movie: movies.popular[index],
                        ),
                      ),
                      separatorBuilder: (_, index) => SizedBox(
                        width: 2.0,
                      ),
                    ),
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

class MoviePosterWidget extends StatelessWidget {
  final MovieModel movie;

  const MoviePosterWidget({Key key, @required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.37,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.indigo[900],
            blurRadius: 6.0,
            spreadRadius: 4.0,
          ),
          BoxShadow(
            color: Colors.white,
            blurRadius: 6.0,
            spreadRadius: 4.0,
          ),
        ],
        color: Colors.grey,
        image: DecorationImage(
          fit: BoxFit.contain,
          image: NetworkImage(ApiURL.posterBaseURL + movie.posterPath),
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.8,
      decoration: BoxDecoration(
        color: Colors.grey,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(ApiURL.posterBaseURL + movie.backdropPath),
        ),
      ),
    );
  }
}
