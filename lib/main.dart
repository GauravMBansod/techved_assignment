import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techvedassignment/take_picture_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: MyHomePage(title: 'Flutter Demo Home Page', camera: firstCamera),
  ));
}

class MyHomePage extends StatefulWidget {
  final CameraDescription camera;
  MyHomePage({Key key, this.title, this.camera}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String imagePath;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(24))),
              child: Row(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          maxRadius: 45.0,
                          backgroundImage: imagePath == null
                              ? AssetImage('')
                              : Image.file(File(imagePath)).image,
                        ),
                      ),
                      Positioned(
                          bottom: 1.0,
                          right: 1.0,
                          child: Center(
                            child: Ink(
                              child: IconButton(
                                iconSize: 30.0,
                                icon: Icon(Icons.camera),
                                color: Colors.black,
                                onPressed: () async {
                                  var result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TakePictureScreen(
                                        camera: widget.camera,
                                      ),
                                    ),
                                  );

                                  setState(() {
                                    imagePath = result;
                                  });
                                },
                              ),
                            ),
                          ))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "Jennifer Wilson",
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: Colors.grey.shade600,
                              size: 24.0,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              'Mumbai ,India ',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.calendar_today,
                              color: Colors.grey.shade600,
                              size: 24.0,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              '12 APR 1994 ',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Health Advisor",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(8),
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    return healthAdvisorHolder(width: width);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Health Reward",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Explore our Insurance Product",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    return insuranceProductHolder();
                  }),
            ),
          ],
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: BottomAppBar(
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    bottomNavigation(
                      icon: Icons.note,
                      title: 'My policies',
                      onPressed: () {},
                    ),
                    bottomNavigation(
                      icon: Icons.local_hospital,
                      title: 'Loacte Hospital',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 30.0,
              ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    bottomNavigation(
                      icon: Icons.event_note,
                      title: 'Raise Claim',
                      onPressed: () {},
                    ),
                    bottomNavigation(
                      icon: Icons.bookmark,
                      title: 'Book Services',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
          color: Colors.blueGrey,
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.home),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget bottomNavigation(
      {@required IconData icon,
      @required String title,
      @required Function onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(icon),
            color: Colors.white,
            onPressed: onPressed,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 8.0, color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget insuranceProductHolder() {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(Radius.circular(24))),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            maxRadius: 36.0,
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Health Insurance Redefined',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Lorem ipsum dolor sitamet is a placeholder text....',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget healthAdvisorHolder({@required double width}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: width * 0.8,
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.only(bottom: 8.0),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.all(Radius.circular(24))),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'From treatment guidance to post hospitalization care',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    onPressed: () {},
                    child: Text('Get in touch'),
                    textColor: Colors.white,
                    color: Colors.blue,
                  )
                ],
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            SizedBox(
              height: 48.0,
              width: 48.0,
              child: Image.asset('assets/images/medical_sign.png'),
            )
          ],
        ),
      ),
    );
  }
}
