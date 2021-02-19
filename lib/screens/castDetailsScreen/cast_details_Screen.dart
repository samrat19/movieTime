import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movitm/logic/bloc/person/person_details_bloc.dart';
import 'package:movitm/screens/castDetailsScreen/cast_biography_segment.dart';
import 'package:movitm/tools/app_utils.dart';
import 'cast_gradient_image.dart';
import 'image_segment.dart';
import 'movie_segment.dart';
import 'social_media_segment.dart';

class CastDetailsScreen extends StatelessWidget {
  final int heroTag;

  const CastDetailsScreen({Key key, @required this.heroTag}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            StreamBuilder<PersonDetailsManager>(
                stream: PersonDetailsBloc().personDetailsStream,
                builder:
                    (context, AsyncSnapshot<PersonDetailsManager> snapshot) {
                  if (snapshot.hasData) {
                    var person = snapshot.data?.person;
                    var movies = snapshot.data?.movies;
                    var images = snapshot.data?.images;
                    var links = snapshot.data?.links;
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CastGradientImage(
                            heroTag: heroTag,
                            person: person,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          CastBiographySegment(
                            person: person,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
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
                          movies != null
                              ? ImageSegment(
                                  images: images,
                                )
                              : Text(''),
                          SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
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
                          movies != null
                              ? MovieSegment(
                                  movies: movies,
                                )
                              : Text(''),
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
                          links != null
                              ? SocialMediaSegment(
                                  links: links,
                                )
                              : Text(''),
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
    );
  }
}
