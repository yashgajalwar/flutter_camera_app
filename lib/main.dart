import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';

// Future<void> main() async => runApp(MyApp());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  XFile? _image;
  Future getImage(bool isCamera) async {
    XFile? image;
    final ImagePicker _picker = ImagePicker();
    if (isCamera) {
      image = await _picker.pickImage(source: ImageSource.camera);
    } else {
      image = await _picker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Camera Integration'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                      onPressed: () {
                        getImage(false);
                      },
                      icon: Icon(Icons.insert_drive_file)),
                  SizedBox(
                    width: 10.0,
                  ),
                  IconButton(
                      onPressed: () {
                        getImage(true);
                      },
                      icon: Icon(Icons.camera_alt)),
                ],
              ),
              Column(
                children: [
                  _image == null
                      ? Container()
                      : Image.file(
                          File(_image!.path),
                          height: 300,
                          width: 200,
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
