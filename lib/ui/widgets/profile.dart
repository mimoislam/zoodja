import 'package:flutter/material.dart';
import 'package:zoodja/ui/widgets/photo.dart';

Widget profileWidget({
  padding,
  photoHeight,
  photoWidth,
  clipRadius,
  photo,
  containerHeight,
  containerWidth,
  child,child2
}){
return Padding(
  padding: EdgeInsets.all(padding),
  child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(clipRadius),
    ),
    child:Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: photoWidth,
              height: photoHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(clipRadius),
                child: PhotoWidget( photoLink: photo,),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  gradient:  LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black54,
                      Colors.black87,
                      Colors.black
                    ],
                    stops: [0.1,0.2,0.4,0.9],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter
                  ),
                  color: Colors.black45,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(clipRadius),bottomRight: Radius.circular(clipRadius)),

                ),
                width: photoWidth,
                height:photoHeight*0.25,
                child: child,
              ),
            ),

          ],
        ),
        child2==null?Container():child2
      ],
    ),
  ),

);
}