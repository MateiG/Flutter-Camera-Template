import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CameraController _controller;
  bool initialized = false;

  @override
  void initState() {
    super.initState();
    _initApp();
  }

  _initApp() {
    availableCameras().then((cameras) {
      _controller = CameraController(
      cameras.first,
      ResolutionPreset.max,
      );
      _controller.initialize().whenComplete((){
        setState(() {
          initialized = true;
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          initialized ? Expanded(
            child: OverflowBox(
              maxWidth: double.infinity,
              child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: CameraPreview(_controller)))) : Container(),
        ],
      ),
    );
  }
}