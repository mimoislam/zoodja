import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
class PhotoWidget extends StatelessWidget {
final String photoLink;

  const PhotoWidget({this.photoLink}) ;

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      photoLink,
      fit:  BoxFit.fill,
      cache: true,
      enableSlideOutPage: true,
      filterQuality: FilterQuality.high,
      loadStateChanged: (state) {
        switch (state.extendedImageLoadState){
          case LoadState.loading:
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case LoadState.completed:
            return null;
            break;
          case LoadState.failed:
            return GestureDetector(
              child: Center(
                child: Text("Reaload"),
              ),
              onTap: ()
              {
                state.reLoadImage();
              },
            );
            break;

        }
        return Text("");
      },
    );
  }
}
