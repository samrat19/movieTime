import 'package:flutter/material.dart';
import 'package:movitm/assets/api_url.dart';
import 'package:movitm/logic/bloc/home_screen_bloc.dart';
import 'package:movitm/logic/model/movie_model.dart';
import 'package:movitm/logic/movie_response.dart';
import 'package:movitm/tools/movie_poster_widget.dart';

class MovieDetailsScreen extends StatelessWidget {
  final MovieModel movie;

  const MovieDetailsScreen({Key key, @required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    print(movie.id.toString());

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image:
                        NetworkImage(ApiURL.posterBaseURL + movie.backdropPath),
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: height * 0.22,
                    child: Row(
                      children: [
                        Container(
                          width: width * 0.3,
                          child: Image.network(
                            ApiURL.posterBaseURL + movie.posterPath,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                            ),
                            child: Text(
                              movie.title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black,
                      Colors.indigo[900],
                    ],
                    begin: Alignment(0, -1),
                    end: Alignment(0, 1),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.overview,
                      style:
                          TextStyle(color: Colors.indigo[300], fontSize: 20.0),
                    ),
                    Text(
                      'Similar Movies',
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                    StreamBuilder<MovieResponse>(
                      stream: MovieBloc().similarMovie,
                      builder: (_,AsyncSnapshot<MovieResponse> snapShot){
                        return snapShot.hasData?Container(
                          height: height * 0.3,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapShot.data.movieList.length,
                            itemBuilder: (_, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MoviePosterWidget(
                                movie: snapShot.data.movieList[index],
                              ),
                            ),
                            separatorBuilder: (_, index) => SizedBox(
                              width: 2.0,
                            ),
                          ),
                        ):CircularProgressIndicator();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
