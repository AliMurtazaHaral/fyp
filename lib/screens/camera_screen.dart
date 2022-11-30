// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:video_player/video_player.dart';
import 'package:camera/camera.dart';
import '../utils/fonts.dart';
import '../widgets/buttons.dart';
import 'camera/camera_screen.dart';
class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width*1,
                child: Text("You can take realtime picture of mechanic. And check he is real or fake for security purposes.", maxLines: 3,
                    softWrap: false,overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20, color: primaryColor)),
              ),
              Image.asset('assets/images/image.gif'),
              RoundedButton.roundedButton(
                  context,
                  "assets/images/camera.jpg",
                  "Take a Snap", onTap: () async{
                await availableCameras().then((value) => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => CameraPage(cameras: value))));
              }),
            ],
          ),
        )
      ),
    );
  }
}