import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movitm/assets/api_url.dart';
import 'package:movitm/logic/bloc/home_screen/home_screen_bloc.dart';
import 'package:movitm/logic/bloc/movie_details/movie_details_bloc.dart';
import 'package:movitm/logic/bloc/person/person_details_bloc.dart';
import 'package:movitm/logic/model/movie_model.dart';
import 'package:movitm/screens/movieDetailsScreen/movie_title_section.dart';
import 'package:movitm/tools/app_utils.dart';
import '../castDetailsScreen/cast_details_Screen.dart';
import 'movie_cast.dart';
import 'movie_genre.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int id;

  const MovieDetailsScreen({Key key, @required this.id}) : super(key: key);

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  List<int> movieID = [];

  @override
  void initState() {
    setState(() {
      movieID.add(widget.id);
    });
    super.initState();
  }

  Future<bool> back() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: back,
      child: SafeArea(
        top: true,
        child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                height: height,
                width: width,
                child: StreamBuilder<MovieDetailsManager>(
                    stream: MovieDetailsBloc().movieDetailsStream,
                    builder:
                        (context, AsyncSnapshot<MovieDetailsManager> snapshot) {
                      if (snapshot.hasData) {
                        var movieDetails = snapshot.data.movieDetails;
                        var movieCast = snapshot.data.movieCast;
                        var similarMovie = snapshot.data.similarMovie;
                        return Column(
                          children: [
                            MovieTitleSection(movieDetails: movieDetails,),
                            Expanded(
                              flex: 3,
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.all(0.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Text(
                                        'Overview',
                                        style: TextStyle(
                                          fontSize: width * 0.09,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        movieDetails.overview,
                                        style: TextStyle(
                                          fontSize: width * 0.04,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Text(
                                        'Genre',
                                        style: TextStyle(
                                          fontSize: width * 0.09,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      MovieGenre(
                                        genres: movieDetails.genres),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Text(
                                        'MovieCast',
                                        style: TextStyle(
                                          fontSize: width * 0.09,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Container(
                                        height: height * 0.2,
                                        width: width,
                                        child: ListView.separated(
                                          separatorBuilder: (_, index) =>
                                              SizedBox(
                                            width: 10.0,
                                          ),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: movieCast?.cast?.length,
                                          itemBuilder: (_, index) {
                                            //print('cast index $index profile path = ${movieCast.cast[index].profilePath}');
                                            return GestureDetector(
                                              onTap: () {
                                                int id =
                                                    movieCast.cast[index].id;
                                                PersonDetailsBloc()
                                                  ..getPerson(id);
                                                PersonDetailsBloc()..init(id);
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                  builder: (_) =>
                                                      CastDetailsScreen(
                                                    heroTag: id,
                                                  ),
                                                ));
                                              },
                                              child: Hero(
                                                tag: movieCast.cast[index].id,
                                                child: MovieCast(
                                                  movieCast: movieCast.cast[index],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Text(
                                        'Similar Movies',
                                        style: TextStyle(
                                          fontSize: 30.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      similarMovie != null
                                          ? Container(
                                              height: height * 0.3,
                                              foregroundDecoration:AppUtils.foreGroundDecoration1,
                                              child: ListView.separated(
                                                  scrollDirection: Axis.horizontal,
                                                  itemCount: similarMovie.movieList.length,
                                                  itemBuilder: (_, index) =>
                                                      Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: poster(context,
                                                              similarMovie.movieList[index],
                                                          ),
                                                      ),
                                                  separatorBuilder:
                                                      (_, index) => SizedBox(width: 2.0),
                                              ),
                                            )
                                          : CircularProgressIndicator(),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: GestureDetector(
                  onTap: () {
                    //list null then pop otherwise load last id
                    //check for item in list
                    if (movieID.length <= 1) {
                      Navigator.pop(context);
                    } else {
                      setState(() {
                        movieID.removeLast();
                        print(movieID.length.toString());
                      });
                      var id = movieID[movieID.length - 1];
                      MovieDetailsBloc()..getSimilarMovies(id);
                      MovieDetailsBloc()..init(id);
                    }
                  },
                  child: Icon(Icons.arrow_back_ios_outlined,
                      color: Colors.grey[200]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget poster(BuildContext context, MovieModel movie) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String imagePath = movie.posterPath == null
        ? ApiURL.nullImage
        : ApiURL.posterBaseURL + movie.posterPath;
    return GestureDetector(
      onTap: () {
        setState(() {
          movieID.add(movie.id);
          print(movieID.length.toString());
        });
        MovieDetailsBloc()..getSimilarMovies(movie.id);
        MovieDetailsBloc()..init(movie.id);
      },
      child: Container(
        width: width * 0.37,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(imagePath),
          ),
        ),
      ),
    );
  }
}
