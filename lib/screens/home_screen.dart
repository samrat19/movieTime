import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movitm/assets/api_url.dart';
import 'package:movitm/logic/bloc/home_screen_bloc.dart';
import 'package:movitm/logic/model/movie_model.dart';
import 'package:movitm/screens/view_all_screen.dart';
import 'package:movitm/tools/movie_poster_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var a = TimeOfDay.now();
    var message;
    if(a.hour>=5 && a.hour<12){
      message = 'Morning';
    }else if(a.hour>=12 && a.hour<17){
      message = 'Afternoon';
    }else if(a.hour>=17 && a.hour<21){
      message = 'Afternoon';
    }else{
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
                        Text(
                          'Good $message',
                          style: TextStyle(
                            fontSize: width*0.15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'Upcoming Movies',
                          style: TextStyle(
                            fontSize: width*0.07,
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
                              end: Alignment(0,1),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Streaming Now',
                              style: TextStyle(
                                fontSize: width*0.07,
                                color: Colors.blueGrey,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                List<MovieModel> list =
                                    movies.popular.movieList;
                                return Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => ViewAllScreen(
                                      segment: ' Streaming Now',
                                      movies: list,
                                      totalPage: movies.streamingNow.totalPages,
                                      url: ApiURL.paginationNowPlayingURL,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'View All',
                                style: TextStyle(
                                    fontSize: width*0.04,
                                    color: Colors.blueGrey,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        MovieSection(
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: movies?.streamingNow?.movieList?.length,
                            itemBuilder: (_, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MoviePosterWidget(
                                movie: movies.streamingNow.movieList[index],
                              ),
                            ),
                            separatorBuilder: (_, index) => SizedBox(
                              width: 2.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Top Rated',
                              style: TextStyle(
                                fontSize: width*0.07,
                                color: Colors.blueGrey,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                List<MovieModel> list =
                                    movies.topRated.movieList;
                                return Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => ViewAllScreen(
                                      segment: ' Top Rated',
                                      movies: list,
                                      url: ApiURL.paginationTopRatedURL,
                                      totalPage: movies.topRated.totalPages,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'View All',
                                style: TextStyle(
                                    fontSize: width*0.04,
                                    color: Colors.blueGrey,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        MovieSection(
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: movies?.topRated?.movieList?.length,
                            itemBuilder: (_, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MoviePosterWidget(
                                movie: movies.topRated.movieList[index],
                              ),
                            ),
                            separatorBuilder: (_, index) => SizedBox(
                              width: 2.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Other Popular',
                              style: TextStyle(
                                fontSize: width*0.07,
                                color: Colors.blueGrey,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                List<MovieModel> list =
                                    movies.popular.movieList;
                                return Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => ViewAllScreen(
                                      segment: ' Popular Movies',
                                      movies: list,
                                      url: ApiURL.paginationPopularURL,
                                      totalPage: movies.popular.totalPages,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'View All',
                                style: TextStyle(
                                    fontSize: width*0.04,
                                    color: Colors.blueGrey,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        MovieSection(
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: movies?.popular?.movieList?.length,
                            itemBuilder: (_, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MoviePosterWidget(
                                movie: movies.popular.movieList[index],
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

class MovieSection extends StatelessWidget {

  final Widget child;

  const MovieSection({Key key, @required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.36,
      foregroundDecoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Colors.grey.withOpacity(0.2),
            Colors.white,
          ],
          begin: Alignment(0, -1),
          end: Alignment(0,1),
        ),
      ),
      child: child,
    );
  }
}
