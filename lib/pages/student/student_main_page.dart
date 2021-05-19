import 'package:flutter/material.dart';
import 'package:scapps_student/blocs/auth/auth_bloc.dart';
import 'package:scapps_student/pages/student/home/student_home_page.dart';
import 'package:scapps_student/pages/student/profile/student_profile_page.dart';

class StudentMainPage extends StatefulWidget {
  final int bottomNavBarIndex;
  final AuthBloc authBloc;

  StudentMainPage({this.bottomNavBarIndex = 0, this.authBloc});

  @override
  _StudentMainPageState createState() => _StudentMainPageState();
}

class _StudentMainPageState extends State<StudentMainPage> {
  int bottomNavBarIndex;
  PageController pageController;
  AuthBloc get _authBloc => widget.authBloc;

  @override
  void initState() {
    super.initState();

    bottomNavBarIndex = widget.bottomNavBarIndex;
    pageController = PageController(initialPage: bottomNavBarIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        PageView(
          controller: pageController,
          onPageChanged: onPageChanged,
          children: [
            StudentHomePage(authBloc: _authBloc),
            StudentProfilePage(authBloc: _authBloc)
          ],
        ),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: bottomNavBarIndex,
        onTap: (index) {
          setState(() {
            bottomNavBarIndex = index;
            pageController.jumpToPage(index);
          });
        },
        selectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontFamily: 'Nunito',
            color: Colors.black),
        unselectedItemColor: Color(0xFFA6A6A6),
        unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontFamily: 'Nunito',
            color: Color(0xFFA6A6A6)),
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'Profile'),
        ],
      ),
    );
  }

  void onPageChanged(int index) {
    setState(() {
      this.bottomNavBarIndex = index;
    });
  }
}
