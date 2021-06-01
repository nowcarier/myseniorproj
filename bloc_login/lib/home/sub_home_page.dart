import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<Projector> fetchProjector() async {
  final response =
      await http.get(Uri.https('smartubuapp.herokuapp.com', 'data'));

  if (response.statusCode == 200) {
    return Projector.fromJson(jsonDecode(response.body)[2]);
  } else {
    throw Exception('Failed to load Detail');
  }
}

class Projector {
  final int id;
  final String projector_status;
  final String datetime;

  Projector({this.id, this.projector_status, this.datetime});

  factory Projector.fromJson(Map<String, dynamic> json) {
    return Projector(
      id: json['id'],
      projector_status: json['projector_status'],
      datetime: json['datetime'],
    );
  }
}

Future<Air> fetchAir() async {
  final response =
      await http.get(Uri.https('smartubuapp.herokuapp.com', 'data'));

  if (response.statusCode == 200) {
    return Air.fromJson(jsonDecode(response.body)[0]);
  } else {
    throw Exception('Failed to load Detail');
  }
}

class Air {
  final int id;
  final String air_conditioner_status;
  final String datetime;

  Air({this.id, this.air_conditioner_status, this.datetime});

  factory Air.fromJson(Map<String, dynamic> json) {
    return Air(
      id: json['id'],
      air_conditioner_status: json['air_conditioner_status'],
      datetime: json['datetime'],
    );
  }
}

Future<Light> fetchLight() async {
  final response =
      await http.get(Uri.https('smartubuapp.herokuapp.com', 'data'));

  if (response.statusCode == 200) {
    return Light.fromJson(jsonDecode(response.body)[1]);
  } else {
    throw Exception('Failed to load Detail');
  }
}

class Light {
  final int id;
  final String light_status;
  final String datetime;

  Light({this.id, this.light_status, this.datetime});

  factory Light.fromJson(Map<String, dynamic> json) {
    return Light(
      id: json['id'],
      light_status: json['light_status'],
      datetime: json['datetime'],
    );
  }
}

class Subhomepage extends StatelessWidget {
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
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Future<Projector> ProjectorDetail;
  Future<Air> AirDetail;
  Future<Light> LightDetail;

  Future<Null> _refresh() {
    return Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (a, b, c) => Subhomepage(), transitionDuration: Duration(seconds: 0)));
  }

  //
  @override
  void initState() {
    super.initState();

    ProjectorDetail = fetchProjector();
    AirDetail = fetchAir();
    LightDetail = fetchLight();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refresh,
          child: ListView(children: [
            Container(
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
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    child: _MainTextStyle('SMART ROOM', 28.0),
                  ),
                  SizedBox(
                    height: 45,
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
                                //behind card
                                Container(
                                  height: 500,
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
                              //Main Card
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
                                  width: 320,
                                  height: 500,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'SC121',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Kanit',
                                                color: Colors.black),
                                          ),
                                        ],
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
                                            bottomLeft:
                                                const Radius.circular(15),
                                            bottomRight:
                                                const Radius.circular(15),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 3,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  0), // changes position of shadow
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
                                      //โปรเจคเตอร์
                                      Container(
                                        decoration: new BoxDecoration(
                                          border: Border.all(
                                              color: Colors.red, width: 3),
                                          color: Colors.white,
                                          borderRadius: new BorderRadius.only(
                                            topLeft: const Radius.circular(30),
                                            topRight: const Radius.circular(30),
                                            bottomLeft:
                                                const Radius.circular(30),
                                            bottomRight:
                                                const Radius.circular(30),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.1),
                                              spreadRadius: 3,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  0), // changes position of shadow
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
                                                          fontSize: 15,
                                                          fontFamily: 'Kanit',
                                                          color: Colors.black),
                                                    ),
                                                    Center(
                                                      child: FutureBuilder<
                                                          Projector>(
                                                        future: ProjectorDetail,
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            return Text(
                                                                snapshot.data
                                                                    .projector_status,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
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
                                        height: 10,
                                      ),
                                      //แอร์
                                      Container(
                                        decoration: new BoxDecoration(
                                          border: Border.all(
                                              color: Colors.green, width: 3),
                                          color: Colors.white,
                                          borderRadius: new BorderRadius.only(
                                            topLeft: const Radius.circular(30),
                                            topRight: const Radius.circular(30),
                                            bottomLeft:
                                                const Radius.circular(30),
                                            bottomRight:
                                                const Radius.circular(30),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.1),
                                              spreadRadius: 3,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  0), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        height: 80,
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
                                                          fontSize: 15,
                                                          fontFamily: 'Kanit',
                                                          color: Colors.black),
                                                    ),
                                                    Center(
                                                      child: FutureBuilder<Air>(
                                                        future: AirDetail,
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            return Text(
                                                                snapshot.data
                                                                    .air_conditioner_status,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
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
                                        height: 10,
                                      ),
                                      //ไฟ
                                      Container(
                                        decoration: new BoxDecoration(
                                          border: Border.all(
                                              color: Colors.blue, width: 3),
                                          color: Colors.white,
                                          borderRadius: new BorderRadius.only(
                                            topLeft: const Radius.circular(30),
                                            topRight: const Radius.circular(30),
                                            bottomLeft:
                                                const Radius.circular(30),
                                            bottomRight:
                                                const Radius.circular(30),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.1),
                                              spreadRadius: 3,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  0), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        height: 80,
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
                                                          fontSize: 15,
                                                          fontFamily: 'Kanit',
                                                          color: Colors.black),
                                                    ),
                                                    Center(
                                                      child:
                                                          FutureBuilder<Light>(
                                                        future: LightDetail,
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            return Text(
                                                                snapshot.data
                                                                    .light_status,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
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
                            height: 25,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Homepage()),
                              );
                            },
                            child: Container(
                                decoration: new BoxDecoration(
                                  gradient: new LinearGradient(
                                      colors: [
                                        const Color(0xFF91EA9E),
                                        const Color(0xFFDDE6E1),
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
                                      offset: Offset(
                                          0, 0), // changes position of shadow
                                    ),
                                  ],
                                ),
                                width: MediaQuery.of(context).size.width * 0.65,
                                height:
                                    MediaQuery.of(context).size.width * 0.12,
                                child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(110, 10, 0.0, 0.0),
                                    child: _MainTextStyle('กลับ', 17.0))),
                          ),
                          SizedBox(
                            height: 20,
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
          ])),
    );
  }
}

Widget _MainTextStyle(String text, size) {
  return Text(
    text,
    style: TextStyle(fontSize: size, fontFamily: 'Kanit', color: Colors.white),
  );
}
