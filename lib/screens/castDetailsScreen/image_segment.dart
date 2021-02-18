import 'package:flutter/material.dart';
import 'package:movitm/assets/api_url.dart';
import 'package:movitm/logic/model/person/person_image_model.dart';

class ImageSegment extends StatelessWidget {

  final PersonImageModel images;

  const ImageSegment({Key key, @required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.3,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: images.profiles.length,
        itemBuilder: (_, index) {
          var imagePath = ApiURL.posterBaseURL + images.profiles[index].filePath;
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