import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movitm/assets/api_url.dart';
import 'package:movitm/logic/bloc/person/person_details_bloc.dart';
import 'package:movitm/tools/app_utils.dart';
import 'image_segment.dart';
import 'movie_segment.dart';
import 'social_media_segment.dart';

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
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.grey.withOpacity(0.2),
                Colors.white,
              ],
              begin: Alignment(0,-1),
              end: Alignment(1,0),
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              StreamBuilder<PersonDetailsManager>(
                  stream: PersonDetailsBloc().personDetailsStream,
                  builder: (context, AsyncSnapshot<PersonDetailsManager> snapshot) {
                    if (snapshot.hasData) {
                      var person = snapshot.data?.person;
                      var movies = snapshot.data?.movies;
                      var images = snapshot.data?.images;
                      var links = snapshot.data?.links;
                      return SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Hero(
                                      child: Container(
                                        width: width,
                                        height: height*0.8,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  ApiURL.posterBaseURL +
                                                      person.profilePath,
                                              ),
                                          ),
                                        ),
                                        foregroundDecoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.transparent,
                                              Colors.grey.withOpacity(0.2),
                                              Colors.white,
                                            ],
                                            begin: Alignment(0,-1),
                                            end: Alignment(0,1),
                                          ),
                                        ),
                                      ),
                                      tag: heroTag,
                                    ),
                                    Positioned(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              person.name,
                                              style: TextStyle(
                                                fontSize: person.name.length>12?width*0.12:width*0.15,
                                                color: Colors.blueGrey[700],
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Popularity',
                                                  style: TextStyle(
                                                    fontSize: 30.0,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(width: 10.0,),
                                                Text(
                                                  person.popularity.toString(),
                                                  style: TextStyle(
                                                    fontSize: 30.0,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                        ),
                                      ),
                                      bottom: 20.0,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:8.0),
                                  child: Text(
                                    person.biography,
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:8.0),
                                  child: Text(
                                    'Other Images',
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                movies != null ? ImageSegment(images: images,):Text(''),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:8.0),
                                  child: Text(
                                    'Movies',
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                movies != null ? MovieSegment(movies: movies,) : Text(''),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Center(
                                  child: Text(
                                    'Available on',
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                links != null ? SocialMediaSegment(links: links,) :Text(''),
                              SizedBox(
                                height: 10.0,
                              ),
                              ],
                            ),
                          );
                    } else {
                      return CupertinoActivityIndicator();
                    }
                  }),
              Positioned(
                top: 10,
                left: 10,
                child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: AppUtils.backButton,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



