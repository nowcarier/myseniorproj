import 'package:bloc_login/home/sub_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_login/bloc/authentication_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class Homepage extends StatelessWidget {
  Homepage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            Padding(
                padding: EdgeInsets.fromLTRB(290.0, 70.0, 0.0, 0.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                )),
            Padding(
              padding: EdgeInsets.fromLTRB(34.0, 0.0, 0.0, 0.0),
              child: _MainTextStyle('Samrt room', 28.0),
            ),
            SizedBox(
              height: 20,
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
                // _MainTextStyle('Nowsir', 20.0)
              ],
            ),
            SizedBox(
              height: 26,
            ),
            Stack(
              children: [
                Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Stack(
                        children: [
                          Container(
                            height: 434,
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
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Subhomepage()),
                            );
                          },
                          child: Container(
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
                              width: 150,
                              height: 160,
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
                                    height: 10,
                                  ),
                                  Container(
                                    width: 80,
                                    height: 80,
                                    color: Colors.green,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 40.5,
                                      ),
                                      Text(
                                        'สถานะ',
                                        style: TextStyle(
                                            fontFamily: 'Kanit', fontSize: 16),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      CustomPaint(
                                          painter: DrawCircle(Colors.green)),
                                    ],
                                  )
                                ],
                              )),
                        ),
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
                            width: 150,
                            height: 160,
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
                                  height: 10,
                                ),
                                Container(
                                  width: 80,
                                  height: 80,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 40.5,
                                    ),
                                    Text(
                                      'สถานะ',
                                      style: TextStyle(
                                          fontFamily: 'Kanit', fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    CustomPaint(
                                        painter: DrawCircle(Colors.green)),
                                  ],
                                )
                              ],
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                            width: 150,
                            height: 160,
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
                                  height: 10,
                                ),
                                Container(
                                  width: 80,
                                  height: 80,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 40.5,
                                    ),
                                    Text(
                                      'สถานะ',
                                      style: TextStyle(
                                          fontFamily: 'Kanit', fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    CustomPaint(
                                        painter: DrawCircle(Colors.green)),
                                  ],
                                )
                              ],
                            )),
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
                            width: 150,
                            height: 160,
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
                                  height: 10,
                                ),
                                Container(
                                  width: 80,
                                  height: 80,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 40.5,
                                    ),
                                    Text(
                                      'สถานะ',
                                      style: TextStyle(
                                          fontFamily: 'Kanit', fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    CustomPaint(
                                        painter: DrawCircle(Colors.green)),
                                  ],
                                )
                              ],
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(LoggedOut());
                      },
                      child: Container(
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
                            borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(10),
                              topRight: const Radius.circular(10),
                              bottomLeft: const Radius.circular(10),
                              bottomRight: const Radius.circular(10),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
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
                              padding: EdgeInsets.fromLTRB(75, 8, 0.0, 0.0),
                              child: _MainTextStyle('ออกจากระบบ', 17.0))),
                    ),
                    SizedBox(
                      height: 10,
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
