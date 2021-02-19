import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../logic/model/person_model.dart';

class CastBiographySegment extends StatefulWidget {

  final PersonModel person;

  const CastBiographySegment({Key key, @required this.person}) : super(key: key);

  @override
  _CastBiographySegmentState createState() => _CastBiographySegmentState();
}

class _CastBiographySegmentState extends State<CastBiographySegment> {

  bool readMore = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: RichText(
        text: TextSpan(
            text: readMore?widget.person.biography:widget.person.biography.substring(0, 150),
            style: TextStyle(
                fontSize: 17.0, color: Colors.black),
            children: [
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    if(readMore == false){
                      setState(() {
                        readMore = true;
                      });
                    }else{
                      setState(() {
                        readMore = false;
                      });
                    }
                  },
                text: readMore?'...VIEW LESS':'...READ MORE',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
      ),
    );
  }
}
