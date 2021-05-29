import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scapps_student/blocs/auth/auth_bloc.dart';
import 'package:scapps_student/blocs/auth/auth_event.dart';
import 'package:scapps_student/blocs/auth/auth_state.dart';
import 'package:scapps_student/services/auth_service.dart';
import 'package:scapps_student/utils/theme.dart';

class StudentHomePage extends StatefulWidget {
  final AuthBloc authBloc;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  StudentHomePage({Key key, this.authBloc, this.analytics, this.observer})
      : super(key: key);

  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  final AuthService authService = AuthService();
  AuthBloc get _authBloc => widget.authBloc;

  DateTime currentBackPressTime;

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark));

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocBuilder(
          bloc: _authBloc,
          // ignore: missing_return
          builder: (context, state) {
            if (state is AuthStudentHasToken) {
              _authBloc.add(GetStudentUserProfile(state.token));
              return Container();
            }
            if (state is StudentProfile) {
              return Scaffold(
                backgroundColor: Color(0xFF333333),
                body: WillPopScope(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 40.0,
                              ),
                              Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                                text: "Selamat Datang,\n",
                                                style: textNormal.copyWith(
                                                    color: Colors.white,
                                                    fontSize: 20)),
                                            TextSpan(
                                                text: state.name,
                                                style: textNormal.copyWith(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24))
                                          ])),
                                          Container(
                                              width: 100.0,
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: NetworkImage(
                                                          state.image)))),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30.0,
                                    ),
                                    Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20.0),
                                              topRight: Radius.circular(20.0),
                                            ),
                                            color: Colors.white),
                                        constraints: BoxConstraints(
                                          minHeight: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              200.0,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 32.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    MaterialButton(
                                                      onPressed: () {
                                                        print("test");
                                                      },
                                                      color: Colors.red,
                                                      child: Icon(
                                                        Icons
                                                            .date_range_rounded,
                                                        size: 24,
                                                        color: Colors.white,
                                                      ),
                                                      padding:
                                                          EdgeInsets.all(16),
                                                      shape: CircleBorder(),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            size.height * 0.01),
                                                    Text("Jadwal",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            textNormal.copyWith(
                                                                fontSize: 12))
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    MaterialButton(
                                                      onPressed: () {
                                                        print("test");
                                                      },
                                                      color: Colors.green,
                                                      child: Icon(
                                                        Icons.check_box,
                                                        color: Colors.white,
                                                        size: 24,
                                                      ),
                                                      padding:
                                                          EdgeInsets.all(16),
                                                      shape: CircleBorder(),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            size.height * 0.01),
                                                    Text("Absensi",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            textNormal.copyWith(
                                                                fontSize: 12))
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    MaterialButton(
                                                      onPressed: () {
                                                        print("test");
                                                      },
                                                      color: Colors.blue,
                                                      child: Icon(
                                                        Icons.book,
                                                        color: Colors.white,
                                                        size: 24,
                                                      ),
                                                      padding:
                                                          EdgeInsets.all(16),
                                                      shape: CircleBorder(),
                                                    ),
                                                    SizedBox(
                                                        height: size.height *
                                                            0.005),
                                                    Text("Kelas",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            textNormal.copyWith(
                                                                fontSize: 12))
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    MaterialButton(
                                                      onPressed: () =>
                                                          _onOtherPressed(),
                                                      color: Colors.grey,
                                                      child: Icon(
                                                        Icons.dashboard,
                                                        size: 24,
                                                        color: Colors.white,
                                                      ),
                                                      padding:
                                                          EdgeInsets.all(16),
                                                      shape: CircleBorder(),
                                                    ),
                                                    SizedBox(
                                                        height: size.height *
                                                            0.005),
                                                    Text("Lainnya",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            textNormal.copyWith(
                                                                fontSize: 12))
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: size.height * 0.04,
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 18.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      RichText(
                                                        text: TextSpan(
                                                          text:
                                                              "Jadwal Hari Ini",
                                                          style: textNormal
                                                              .copyWith(
                                                                  fontSize: 16),
                                                        ),
                                                      ),
                                                      Text(
                                                        "Selengkapnya",
                                                        style:
                                                            textNormal.copyWith(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 16),
                                                      )
                                                    ],
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 8, top: 8),
                                                    padding: EdgeInsets.all(10),
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[200],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "07:00",
                                                              style: textNormal.copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14),
                                                            ),
                                                            Text("s/d",
                                                                style: textNormal
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .grey,
                                                                        fontSize:
                                                                            12)),
                                                            Text(
                                                              "07.45",
                                                              style: textNormal.copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14),
                                                            )
                                                          ],
                                                        ),
                                                        Container(
                                                          height: 100,
                                                          width: 1,
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width -
                                                                  160,
                                                              child: Text(
                                                                "Pemprogramman Dasar",
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: textNormal.copyWith(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .location_on,
                                                                  color: Colors
                                                                      .grey,
                                                                  size: 20,
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width -
                                                                      160,
                                                                  child: Text(
                                                                      "Lab Programming",
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: textNormal.copyWith(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontSize:
                                                                              14)),
                                                                )
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                CircleAvatar(
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                          "https://i.imgur.com/9f9BpzO.jpg"),
                                                                  radius: 10,
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  "Alan Sekha",
                                                                  style: textNormal.copyWith(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 8, top: 8),
                                                    padding: EdgeInsets.all(10),
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[200],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "07:45",
                                                              style: textNormal.copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14),
                                                            ),
                                                            Text("s/d",
                                                                style: textNormal
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .grey,
                                                                        fontSize:
                                                                            12)),
                                                            Text(
                                                              "08.30",
                                                              style: textNormal.copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14),
                                                            )
                                                          ],
                                                        ),
                                                        Container(
                                                          height: 100,
                                                          width: 1,
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width -
                                                                  160,
                                                              child: Text(
                                                                "Pemprogramman Dasar",
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: textNormal.copyWith(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .location_on,
                                                                  color: Colors
                                                                      .grey,
                                                                  size: 20,
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width -
                                                                      160,
                                                                  child: Text(
                                                                      "Lab Programming",
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: textNormal.copyWith(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontSize:
                                                                              14)),
                                                                )
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                CircleAvatar(
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                          "https://i.imgur.com/9f9BpzO.jpg"),
                                                                  radius: 10,
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  "Alan Sekha",
                                                                  style: textNormal.copyWith(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 18.0,
                                                  vertical: 12),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      RichText(
                                                        text: TextSpan(
                                                          text: "Pengumuman",
                                                          style: textNormal
                                                              .copyWith(
                                                                  fontSize: 16),
                                                        ),
                                                      ),
                                                      Text(
                                                        "Selengkapnya",
                                                        style:
                                                            textNormal.copyWith(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 16),
                                                      )
                                                    ],
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 8, top: 8),
                                                    padding: EdgeInsets.all(10),
                                                    height: 80,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[200],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width -
                                                                      80,
                                                                  child: Text(
                                                                    "Pembagian Kuota Kemendikbud",
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: textNormal.copyWith(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  "21 Februari 2021",
                                                                  style: textNormal.copyWith(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    onWillPop: onWillPop),
              );
            }
          }),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: "Tekan sekali lagi untuk keluar dari aplikasi.");
      return Future.value(false);
    }
    return Future.value(true);
  }

  void _onOtherPressed() {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.white,
            height: 240,
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10),
                        topRight: const Radius.circular(10))),
                child: Column(
                  children: [
                    Container(
                      height: 5,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            MaterialButton(
                              onPressed: () {
                                print("test");
                              },
                              color: Colors.red,
                              child: Icon(
                                Icons.date_range_rounded,
                                size: 24,
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(16),
                              shape: CircleBorder(),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Text("Jadwal",
                                textAlign: TextAlign.center,
                                style: textNormal.copyWith(fontSize: 12))
                          ],
                        ),
                        Column(
                          children: [
                            MaterialButton(
                              onPressed: () {
                                print("test");
                              },
                              color: Colors.green,
                              child: Icon(
                                Icons.check_box,
                                color: Colors.white,
                                size: 24,
                              ),
                              padding: EdgeInsets.all(16),
                              shape: CircleBorder(),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Text("Absensi",
                                textAlign: TextAlign.center,
                                style: textNormal.copyWith(fontSize: 12))
                          ],
                        ),
                        Column(
                          children: [
                            MaterialButton(
                              onPressed: () {
                                print("test");
                              },
                              color: Colors.blue,
                              child: Icon(
                                Icons.book,
                                color: Colors.white,
                                size: 24,
                              ),
                              padding: EdgeInsets.all(16),
                              shape: CircleBorder(),
                            ),
                            SizedBox(height: size.height * 0.005),
                            Text("Kelas",
                                textAlign: TextAlign.center,
                                style: textNormal.copyWith(fontSize: 12))
                          ],
                        ),
                        Column(
                          children: [
                            MaterialButton(
                              onPressed: () {
                                print("test");
                              },
                              color: Colors.yellow[600],
                              child: Icon(
                                Icons.auto_stories,
                                size: 24,
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(16),
                              shape: CircleBorder(),
                            ),
                            SizedBox(height: size.height * 0.005),
                            Text("Raport",
                                textAlign: TextAlign.center,
                                style: textNormal.copyWith(fontSize: 12))
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            MaterialButton(
                              onPressed: () {
                                print("test");
                              },
                              color: Colors.orange[300],
                              child: Icon(
                                Icons.money,
                                size: 24,
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(16),
                              shape: CircleBorder(),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Text("SPM",
                                textAlign: TextAlign.center,
                                style: textNormal.copyWith(fontSize: 12))
                          ],
                        ),
                        Column(
                          children: [
                            MaterialButton(
                              onPressed: () {
                                print("test");
                              },
                              color: Colors.blue[400],
                              child: Icon(
                                Icons.library_books,
                                color: Colors.white,
                                size: 24,
                              ),
                              padding: EdgeInsets.all(16),
                              shape: CircleBorder(),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Text("Perpustakaan",
                                textAlign: TextAlign.center,
                                style: textNormal.copyWith(fontSize: 12))
                          ],
                        ),
                        Column(
                          children: [
                            MaterialButton(
                              onPressed: () {
                                print("test");
                              },
                              color: Colors.purple,
                              child: Icon(
                                Icons.wifi,
                                color: Colors.white,
                                size: 24,
                              ),
                              padding: EdgeInsets.all(16),
                              shape: CircleBorder(),
                            ),
                            SizedBox(height: size.height * 0.005),
                            Text("Wifi",
                                textAlign: TextAlign.center,
                                style: textNormal.copyWith(fontSize: 12))
                          ],
                        ),
                        Column(
                          children: [
                            MaterialButton(
                              onPressed: () {
                                print("test");
                              },
                              color: Colors.purple[400],
                              child: Icon(
                                Icons.report,
                                size: 24,
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(16),
                              shape: CircleBorder(),
                            ),
                            SizedBox(height: size.height * 0.005),
                            Text("Lapor",
                                textAlign: TextAlign.center,
                                style: textNormal.copyWith(fontSize: 12))
                          ],
                        ),
                      ],
                    ),
                  ],
                )),
          );
        });
  }
}
