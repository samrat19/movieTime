import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movitm/assets/api_url.dart';
import 'package:movitm/logic/bloc/home_screen_bloc.dart';
import 'package:movitm/logic/bloc/movie_details_bloc.dart';
import 'package:movitm/logic/bloc/person/person_details_bloc.dart';
import 'package:movitm/logic/movie_response.dart';
import 'package:movitm/screens/cast_details_Screen.dart';
import 'package:movitm/tools/movie_poster_widget.dart';

class MovieDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.indigo,
            ],
            begin: Alignment(-1,0),
            end: Alignment(1,1),
          ),
        ),
        child: StreamBuilder<MovieDetailsManager>(
            stream: MovieDetailsBloc().movieDetailsStream,
            builder: (context, AsyncSnapshot<MovieDetailsManager> snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data.movieDetails.id.toString());
                var movieDetails = snapshot.data.movieDetails;
                var movieCast = snapshot.data.movieCast;
                return Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(ApiURL.posterBaseURL +
                                    movieDetails.backdropPath))),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black,
                              Colors.indigo,
                            ],
                            begin: Alignment(-1,0),
                            end: Alignment(1,1),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                movieDetails.title,
                                style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                '${movieDetails.runtime} minutes',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Rating',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  RatingBar(
                                    initialRating: movieDetails.voteAverage,
                                    ratingWidget: RatingWidget(
                                      full: Icon(
                                        Icons.star,
                                        color: Colors.grey,
                                      ),
                                      half: Icon(
                                        Icons.star_half,
                                        color: Colors.grey,
                                      ),
                                      empty: Icon(
                                        Icons.star_border_outlined,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    onRatingUpdate: null,
                                    itemCount: 10,
                                    itemSize: 20.0,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                'Overview',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                movieDetails.overview,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                'Genre',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Wrap(
                                spacing: 10.0,
                                direction: Axis.horizontal,
                                children: movieDetails.genres
                                    .map(
                                      (e) => Container(
                                        decoration: BoxDecoration(
                                          color: Colors.indigo[900],
                                          borderRadius: BorderRadius.all(Radius.circular(12.0),),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
                                          child: Text(
                                            e.name,
                                            style: TextStyle(color: Colors.white,fontSize: 17.0),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                'MovieCast',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
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
                                  separatorBuilder: (_, index) => SizedBox(
                                    width: 10.0,
                                  ),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: movieCast.cast.length,
                                  itemBuilder: (_, index) {
                                    print(
                                        'cast index $index profile path = ${movieCast.cast[index].profilePath}');
                                    return GestureDetector(
                                      onTap: (){
                                        int id = snapshot.data.movieCast.cast[index].id;
                                        MovieDetailsBloc()..getPerson(id);
                                        PersonDetailsBloc()..init(id);
                                        Navigator.of(context).push(MaterialPageRoute(
                                          builder: (_)=>CastDetailsScreen(heroTag: id,),
                                        ));
                                      },
                                      child: Hero(
                                        tag: snapshot.data.movieCast.cast[index].id,
                                        child: MovieCast(
                                          name: movieCast.cast[index].name,
                                          posterURL: movieCast
                                                      .cast[index].profilePath ==
                                                  null
                                              ? null
                                              : ApiURL.posterBaseURL +
                                                  movieCast.cast[index].profilePath,
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
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              StreamBuilder<MovieResponse>(
                                stream: MovieBloc().similarMovie,
                                builder:
                                    (_, AsyncSnapshot<MovieResponse> snapShot) {
                                  return snapShot.hasData
                                      ? Container(
                                          height: height * 0.3,
                                          child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                snapShot.data.movieList.length,
                                            itemBuilder: (_, index) => Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: MoviePosterWidget(
                                                movie: snapShot
                                                    .data.movieList[index],
                                              ),
                                            ),
                                            separatorBuilder: (_, index) =>
                                                SizedBox(
                                              width: 2.0,
                                            ),
                                          ),
                                        )
                                      : CircularProgressIndicator();
                                },
                              ),
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
    );
  }
}

class MovieCast extends StatelessWidget {
  final String posterURL;
  final String name;

  const MovieCast({Key key, this.posterURL, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 0.2,
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(posterURL == null
                    ? 'https://www.vippng.com/png/full/356-3563630_continue-marketing.png'
                    : posterURL),
              ),
            ),
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: 17.0,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
