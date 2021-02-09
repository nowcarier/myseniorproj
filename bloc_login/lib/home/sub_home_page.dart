import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_login/bloc/authentication_bloc.dart';
import 'package:flutter_vlc_player/vlc_player.dart';
import 'package:flutter_vlc_player/vlc_player_controller.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<Album> fetchAlbum() async {
  final response = await http.get(Uri.http('192.168.1.10', 'get/data'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body)[0]);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final String airConditionerStatus;
  final String lightStatus;
  final String projectorStatus;
  final String datetime;

  Album(
      {this.airConditionerStatus,
      this.lightStatus,
      this.projectorStatus,
      this.datetime});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      airConditionerStatus: json['air_conditioner_status'],
      lightStatus: json['light_status'],
      projectorStatus: json['projector_status'],
      datetime: json['datetime'],
    );
  }
}

class Subhomepage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class DrawCircle extends CustomPainter {
  Paint _paint;
  String colors;
  DrawCircle(colors) {
    _paint = Paint()
      ..color = colors
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(0.0, 0.0), 8.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  VlcPlayerController _vlcViewController;
  Future<Album> futureAlbum;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _vlcViewController = new VlcPlayerController();
    futureAlbum = fetchAlbum();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                const Color(0xFF5AE272),
                const Color(0xFFDDE6E1),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.8, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(34.0, 0.0, 0.0, 0.0),
              child: _MainTextStyle('Samrt room', 28.0),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(35, 0.0, 0.0, 0.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.yellowAccent,
                    )),
                SizedBox(
                  width: 10,
                ),
                _MainTextStyle('Nowsir', 20.0)
              ],
            ),
            SizedBox(
              height: 26,
            ),
            Stack(
              children: [
                // first Container
                Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 150,
                      ),
                      Stack(
                        children: [
                          Container(
                            height: 414,
                            decoration: new BoxDecoration(
                              color: Color(0xFFFBFBFB),
                              borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(50),
                                topRight: const Radius.circular(50),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(30),
                                topRight: const Radius.circular(30),
                                bottomLeft: const Radius.circular(30),
                                bottomRight: const Radius.circular(30),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            width: 300,
                            height: 440,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'SC121',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Kanit',
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Container(
                                  decoration: new BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/classroom.png"),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: new BorderRadius.only(
                                      topLeft: const Radius.circular(15),
                                      topRight: const Radius.circular(15),
                                      bottomLeft: const Radius.circular(15),
                                      bottomRight: const Radius.circular(15),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 0), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  height: 120,
                                  width: 200,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'อุปกรณ์ไฟฟ้า',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'Kanit',
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  decoration: new BoxDecoration(
                                    border:
                                        Border.all(color: Colors.red, width: 3),
                                    color: Colors.white,
                                    borderRadius: new BorderRadius.only(
                                      topLeft: const Radius.circular(30),
                                      topRight: const Radius.circular(30),
                                      bottomLeft: const Radius.circular(30),
                                      bottomRight: const Radius.circular(30),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 0), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  height: 90,
                                  width: 200,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Transform.scale(
                                        scale: 0.8,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/projector.PNG"),
                                              fit: BoxFit.values[1],
                                            ),
                                          ),
                                          child:
                                              null /* add child content here */,
                                        ),
                                      )),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'โปรเจคเตอร์',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'Kanit',
                                                color: Colors.black),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'สถานะ: ',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontFamily: 'Kanit',
                                                    color: Colors.black),
                                              ),
                                              Center(
                                                child: FutureBuilder<Album>(
                                                  future: futureAlbum,
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Text(
                                                          snapshot.data
                                                              .projectorStatus,
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  'Kanit',
                                                              color: Colors
                                                                  .black));
                                                    } else if (snapshot
                                                        .hasError) {
                                                      return Text(
                                                          "${snapshot.error}");
                                                    }
                                                    // By default, show a loading spinner.
                                                    return CircularProgressIndicator();
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  decoration: new BoxDecoration(
                                    border: Border.all(
                                        color: Colors.green, width: 3),
                                    color: Colors.white,
                                    borderRadius: new BorderRadius.only(
                                      topLeft: const Radius.circular(30),
                                      topRight: const Radius.circular(30),
                                      bottomLeft: const Radius.circular(30),
                                      bottomRight: const Radius.circular(30),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 0), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  height: 70,
                                  width: 200,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Transform.scale(
                                        scale: 0.8,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/air.PNG"),
                                              fit: BoxFit.values[1],
                                            ),
                                          ),
                                          child:
                                              null /* add child content here */,
                                        ),
                                      )),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'แอร์',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'Kanit',
                                                color: Colors.black),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'สถานะ: ',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontFamily: 'Kanit',
                                                    color: Colors.black),
                                              ),
                                              Center(
                                                child: FutureBuilder<Album>(
                                                  future: futureAlbum,
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Text(
                                                          snapshot.data
                                                              .projectorStatus,
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  'Kanit',
                                                              color: Colors
                                                                  .black));
                                                    } else if (snapshot
                                                        .hasError) {
                                                      return Text(
                                                          "${snapshot.error}");
                                                    }
                                                    // By default, show a loading spinner.
                                                    return CircularProgressIndicator();
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  decoration: new BoxDecoration(
                                    border: Border.all(
                                        color: Colors.blue, width: 3),
                                    color: Colors.white,
                                    borderRadius: new BorderRadius.only(
                                      topLeft: const Radius.circular(30),
                                      topRight: const Radius.circular(30),
                                      bottomLeft: const Radius.circular(30),
                                      bottomRight: const Radius.circular(30),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 0), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  height: 70,
                                  width: 200,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Transform.scale(
                                        scale: 0.8,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/light.PNG"),
                                              fit: BoxFit.values[1],
                                            ),
                                          ),
                                          child:
                                              null /* add child content here */,
                                        ),
                                      )),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'ไฟ',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'Kanit',
                                                color: Colors.black),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'สถานะ: ',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontFamily: 'Kanit',
                                                    color: Colors.black),
                                              ),
                                              Center(
                                                child: FutureBuilder<Album>(
                                                  future: futureAlbum,
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Text(
                                                          snapshot.data
                                                              .projectorStatus,
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  'Kanit',
                                                              color: Colors
                                                                  .black));
                                                    } else if (snapshot
                                                        .hasError) {
                                                      return Text(
                                                          "${snapshot.error}");
                                                    }
                                                    // By default, show a loading spinner.
                                                    return CircularProgressIndicator();
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Homepage()),
                        );
                      },
                      child: Container(
                          decoration: new BoxDecoration(
                            gradient: new LinearGradient(
                                colors: [
                                  const Color(0xFFDDE6E1),
                                  const Color(0xFF91EA9E),
                                ],
                                begin: const FractionalOffset(0.0, 0.0),
                                end: const FractionalOffset(0.8, 0.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                            borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(10),
                              topRight: const Radius.circular(10),
                              bottomLeft: const Radius.circular(10),
                              bottomRight: const Radius.circular(10),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                          width: MediaQuery.of(context).size.width * 0.65,
                          height: MediaQuery.of(context).size.width * 0.12,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(100, 8, 0.0, 0.0),
                              child: _MainTextStyle('กลับ', 17.0))),
                    ),
                    Stack(
                      children: [
                        ClipPath(
                          clipper: WaveClipperTwo(reverse: true),
                          child: Container(
                            height: 70,
                            color: Color(0xFF5AE272),
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            ClipPath(
                              clipper: WaveClipperTwo(reverse: true),
                              child: Container(
                                height: 60,
                                color: Color(0xFF65F180),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget _MainTextStyle(String text, size) {
  return Text(
    text,
    style: TextStyle(fontSize: size, fontFamily: 'Kanit', color: Colors.white),
  );
}
