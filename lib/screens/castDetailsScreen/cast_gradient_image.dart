import 'package:flutter/material.dart';
import 'package:movitm/assets/api_url.dart';
import 'package:movitm/logic/model/person_model.dart';

class CastGradientImage extends StatelessWidget {

  final heroTag;
  final PersonModel person;

  const CastGradientImage({Key key, @required this.heroTag,
    @required this.person}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Hero(
          child: Container(
            width: width,
            height: height*0.75,
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
                    fontSize: person.name.length>12?width*0.11:width*0.15,
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
    );
  }
}
