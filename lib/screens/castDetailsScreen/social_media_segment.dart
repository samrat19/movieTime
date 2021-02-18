import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movitm/logic/model/person/person_link_model.dart';

class SocialMediaSegment extends StatelessWidget {
  final PersonLinkModel links;

  const SocialMediaSegment({Key key, @required this.links}) : super(key: key);
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
            Icon(FontAwesomeIcons.facebook, color: Colors.black,
              size: width*0.1,),
            Icon(FontAwesomeIcons.instagram, color: Colors.black,
              size: width*0.1,),
            Icon(FontAwesomeIcons.twitter, color: Colors.black,
              size: width*0.1,),
          ],
        ),
      ),
    );
  }
}