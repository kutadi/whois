import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ImageReviewPage extends StatelessWidget {
  final String imagePath;
  final List<String> classes;

  ImageReviewPage({Key key, @required this.imagePath, @required this.classes})
      : super(key: key);

  final GlobalKey _renderKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    final image = Image.file(File(imagePath));
    final imageRatio = (image?.width ?? 1) / (image?.height ?? 1);
    print(image);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          RepaintBoundary(
            key: _renderKey,
            child: Stack(
              children: <Widget>[
                Transform.scale(
                  scale: imageRatio / deviceRatio,
                  child: Center(
                    child: AspectRatio(
                      child: image ?? SizedBox(),
                      aspectRatio: imageRatio,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: size.height,
                    width: size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: FractionalOffset.center,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Color(0xff000000).withOpacity(0.0),
                          Color(0xff000000).withOpacity(0.5)
                        ],
                      ),
                    ),
                    child: SafeArea(
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            bottom: 0,
                            child: Container(
                              height: size.height / 2.5,
                              width: size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  for (String s in classes) ...[
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 30),
                                      child: Text(
                                        s,
                                        textScaleFactor: 2,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ]
                                ],
                              ),
                            ),
                          ),
                          //For debugging:
                          // Align(alignment: Alignment.center,child: Text(classes.join(","), style: infoTextStyle),)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          AroundShareMenu(),
        ],
      ),
    );
  }
}

class AroundShareMenu extends StatelessWidget {
  const AroundShareMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 32,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
