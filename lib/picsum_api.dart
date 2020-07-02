import 'dart:math';

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class PictureApi with ChangeNotifier {
  String mainRequest = 'https://picsum.photos';
  final random = new Random();
  int maxSize = 700;
  int minSize = 200;
  List<Widget> images = [];

  PictureApi() {
    loadImages();
  }

  Widget fetchImage(int index) {
    int width = random.nextInt(maxSize) + minSize; //next(max) + min
    int height = random.nextInt(maxSize) + minSize; //next(max) + min

    String url = '$mainRequest/$width/$height';

    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        children: [
          Container(
            width: 50,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: CircularProgressIndicator(),
            ),
          ),
          Column(
            children: <Widget>[
              FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage, image: url),
              Center(child: Text("Image # $index")),
            ],
          ),
        ],
      ),
    );
  }

  void loadImages() {
    int numberOfImages = 30;
    for (int i = 0; i < numberOfImages; i++) {
      images.add(fetchImage(i));
      Future.delayed(Duration(seconds: 1));
      notifyListeners();
    }
  }
}
