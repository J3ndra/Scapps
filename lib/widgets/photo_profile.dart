import 'package:flutter/material.dart';
import 'package:scapps_student/utils/theme.dart';

class PhotoProfile extends StatelessWidget {
  const PhotoProfile({
    Key key,
    this.name,
    this.nisn,
    this.image,
  }) : super(key: key);
  final String name, nisn, image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240, // 240
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: CustomShape(),
            child: Container(
              height: 150, //150
              color: Colors.black,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 10), //10
                  height: 140, //140
                  width: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 8, //8
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(image),
                    ),
                  ),
                ),
                Text(name,
                    style: textNormal.copyWith(
                      fontSize: 22,
                    )),
                SizedBox(height: 5), //5
                Text(nisn,
                    style: textNormal.copyWith(fontWeight: FontWeight.w400))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height - 100);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
