import 'package:bloc_login/dao/user_dao.dart';
import 'package:bloc_login/home/sub_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_login/bloc/authentication_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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

getUser() async {
  final userDao = UserDao().getUser(0);
  return userDao;
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid =
      new AndroidInitializationSettings('@mipmap/ic_launcher');

  // newFunction() {
  //   final current = DateTime.now();
  //   final startTime = DateTime(2021, 03, 13, 15, 05);
  //   if (current == startTime) {
  //     print('yes');
  //   }
  // }

  showNotification() async {
    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(seconds: 2));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel id',
      'channel name',
      'channel description',
      icon: 'ic_launcher',
      largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'คำเตือน!',
        'พบอุปกรณ์ไฟไฟยังไม่ปิดใช้งาน!',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
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
            GestureDetector(
              onTap: showNotification,
              child: Padding(
                  padding: EdgeInsets.fromLTRB(290.0, 70.0, 0.0, 0.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                  )),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: _MainTextStyle('Smart room', 28.0),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(35, 0.0, 0.0, 0.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.brown.shade800,
                      child: Text('A'),
                    )),
                SizedBox(
                  width: 10,
                ),
                FutureBuilder(
                  future: getUser(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data[0]['username'],
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Kanit',
                            color: Colors.white),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    // By default, show a loading spinner.
                    return CircularProgressIndicator();
                  },
                ),
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
                            height: 530,
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
                                    width: 100,
                                    height: 80,
                                    decoration: new BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/classroom.png"),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: new BorderRadius.only(
                                        topLeft: const Radius.circular(5),
                                        topRight: const Radius.circular(5),
                                        bottomLeft: const Radius.circular(5),
                                        bottomRight: const Radius.circular(5),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 3,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              0), // changes position of shadow
                                        ),
                                      ],
                                    ),
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
                                  width: 100,
                                  height: 80,
                                  decoration: new BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/classroom.png"),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: new BorderRadius.only(
                                      topLeft: const Radius.circular(5),
                                      topRight: const Radius.circular(5),
                                      bottomLeft: const Radius.circular(5),
                                      bottomRight: const Radius.circular(5),
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
                                  width: 100,
                                  height: 80,
                                  decoration: new BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/classroom.png"),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: new BorderRadius.only(
                                      topLeft: const Radius.circular(5),
                                      topRight: const Radius.circular(5),
                                      bottomLeft: const Radius.circular(5),
                                      bottomRight: const Radius.circular(5),
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
                                  width: 100,
                                  height: 80,
                                  decoration: new BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/classroom.png"),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: new BorderRadius.only(
                                      topLeft: const Radius.circular(5),
                                      topRight: const Radius.circular(5),
                                      bottomLeft: const Radius.circular(5),
                                      bottomRight: const Radius.circular(5),
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
                      height: 55,
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
                      height: 74,
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

// ignore: non_constant_identifier_names
Widget _MainTextStyle(String text, size) {
  return Text(
    text,
    style: TextStyle(fontSize: size, fontFamily: 'Kanit', color: Colors.white),
  );
}
