import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movitm/assets/api_url.dart';
import 'package:movitm/logic/bloc/movie_details_bloc.dart';
import 'package:movitm/logic/bloc/person/person_details_bloc.dart';
import 'package:movitm/logic/model/person_model.dart';
import 'package:movitm/tools/movie_poster_widget.dart';

class CastDetailsScreen extends StatelessWidget {
  final int heroTag;

  const CastDetailsScreen({Key key, this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
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
          child: Stack(
            fit: StackFit.expand,
            children: [
              StreamBuilder<PersonModel>(
                  stream: MovieDetailsBloc().personStream,
                  builder: (context, AsyncSnapshot<PersonModel> snapshot) {
                    return snapshot.hasData
                        ? SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal:8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Hero(
                                    child: Center(
                                      child: Container(
                                        width: width * 0.5,
                                        height: height * 0.3,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  ApiURL.posterBaseURL +
                                                      snapshot.data.profilePath)),
                                        ),
                                      ),
                                    ),
                                    tag: heroTag,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Center(
                                    child: Text(
                                      snapshot.data.name,
                                      style: TextStyle(
                                        fontSize: 30.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    snapshot.data.biography,
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    'Other Images',
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  StreamBuilder<PersonDetailsManager>(
                                      stream: PersonDetailsBloc().personDetailsStream,
                                      builder: (context, AsyncSnapshot<PersonDetailsManager>snapshot) => snapshot.hasData?ImageSegment(snapShot: snapshot,):Text('')),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    'Movies',
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  StreamBuilder<PersonDetailsManager>(
                                      stream: PersonDetailsBloc().personDetailsStream,
                                      builder: (context, AsyncSnapshot<PersonDetailsManager>snapshot) => snapshot.hasData ? MovieSegment(snapShot: snapshot,) : Text('')),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Center(
                                    child: Text(
                                      'Available on',
                                      style: TextStyle(
                                        fontSize: 30.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  StreamBuilder<PersonDetailsManager>(
                                      stream: PersonDetailsBloc().personDetailsStream,
                                      builder: (context, AsyncSnapshot<PersonDetailsManager> snapshot) => SocialMediaSegment(snapShot: snapshot,)),
                                ],
                              ),
                            ),
                          )
                        : CupertinoActivityIndicator();
                  }),
              Positioned(
                top: 10,
                left: 10,
                child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back_ios_outlined,
                        color: Colors.grey)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageSegment extends StatelessWidget {

  final AsyncSnapshot<PersonDetailsManager> snapShot;

  const ImageSegment({Key key, @required this.snapShot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.3,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: snapShot.data.images.profiles.length,
        itemBuilder: (_, index) {
          var imagePath = ApiURL.posterBaseURL + snapShot.data.images.profiles[index].filePath;
          return Padding(
            padding:
            const EdgeInsets.all(8.0),
            child: Image.network(imagePath));
        },
        separatorBuilder: (_, index) => SizedBox(width: 2.0),
      ),
    );
  }
}

class MovieSegment extends StatelessWidget {
  final AsyncSnapshot<PersonDetailsManager> snapShot;

  const MovieSegment({Key key, @required this.snapShot}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.3,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: snapShot.data.movies.movies.length,
        itemBuilder: (_, index) {
          print(snapShot.data.movies.movies[index].posterPath);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: MoviePosterWidget(
              movie: snapShot.data.movies.movies[index],
            ),
          );
        },
        separatorBuilder: (_, index) => SizedBox(width: 2.0),
      ),
    );
  }
}


class SocialMediaSegment extends StatelessWidget {
  final AsyncSnapshot<PersonDetailsManager> snapShot;

  const SocialMediaSegment({Key key, @required this.snapShot}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height*0.1,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(FontAwesomeIcons.facebook, color: Colors.white,
              size: width*0.1,),
            Icon(FontAwesomeIcons.instagram, color: Colors.white,
              size: width*0.1,),
            Icon(FontAwesomeIcons.twitter, color: Colors.white,
              size: width*0.1,),
          ],
        ),
      ),
    );
  }
}



