import 'package:flutter/material.dart';
import 'package:zoodja/ui/widgets/photo.dart';


class PhotoLink extends StatelessWidget {
  final String url;
  const PhotoLink({this.url}) ;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body:Column(
          children:[
            Row(
              children: [
                GestureDetector(
              onTap: (){
                Navigator.pop(context);
                },
              child: Icon(Icons.arrow_back_ios))
              ],
            ),
            PhotoWidget(photoLink: url)
          ]
      ),
    );
  }
}
