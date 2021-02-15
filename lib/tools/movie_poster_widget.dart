import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movitm/assets/api_url.dart';
import 'package:movitm/logic/bloc/home_screen_bloc.dart';
import 'package:movitm/logic/bloc/movie_details_bloc.dart';
import 'package:movitm/logic/model/movie_model.dart';
import 'package:movitm/screens/movie_details_screen.dart';

class MoviePosterWidget extends StatelessWidget {
  final MovieModel movie;

  const MoviePosterWidget({Key key, @required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String imagePath = movie.posterPath == null?'https://www.pngrepo.com/download/34896/movie.png':ApiURL.posterBaseURL+movie.posterPath;
    return GestureDetector(
      onTap: (){
        if(movie.id != null){
          MovieBloc()..getSimilarMovies(movie.id);
          MovieDetailsBloc()..init(movie.id);
          return Navigator.of(context).push(MaterialPageRoute(builder: (_)=>MovieDetailsScreen()));
        }else{
          print('no id');
        }
      },
      child: Card(
        elevation: 10,
        clipBehavior: Clip.hardEdge,
        shadowColor: Colors.blueGrey[900],
        margin: EdgeInsets.all(4.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
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
      ),
    );
  }
}