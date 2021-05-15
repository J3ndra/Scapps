// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:introduction_screen/introduction_screen.dart';
// import 'package:scapps_student/widgets/button_widget.dart';

// class OnBoardingPage extends StatelessWidget {
//   @override
//   // ignore: missing_return
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AnnotatedRegion<SystemUiOverlayStyle>(
//         value: SystemUiOverlayStyle.light,
//         child: Container(
//           decoration: BoxDecoration(color: Color(0xFF2DC4BB)),
//           child: SafeArea(
//             child: IntroductionScreen(
//               pages: [
//                 PageViewModel(
//                   title: 'Pengelolaan di era yang yang baru',
//                   body:
//                       'Mulailah beralih ke pendataan yang modern, efektif, dan akurat.',
//                   image: buildImage('assets/images/first.png'),
//                   decoration: getPageDecoration(),
//                 ),
//                 PageViewModel(
//                   title: 'Lebih seru dengan metode absensi yang kekinian.',
//                   body: ' ',
//                   image: buildImage('assets/images/second.png'),
//                   decoration: getPageDecoration(),
//                 ),
//                 PageViewModel(
//                   title: 'Penyampaian lebih efektif',
//                   body:
//                       'Dapatkan informasi secepat mungkin bagaikan tanpa jarak',
//                   footer: ButtonWidget(
//                     text: 'Mulai',
//                     onClicked: () => goToHome(context),
//                   ),
//                   image: buildImage('assets/learn.png'),
//                   decoration: getPageDecoration(),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void goToHome(context) => Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (_) => HomePage()),
//       );

//   Widget buildImage(String path) =>
//       Center(child: Image.asset(path, width: 350));

//   DotsDecorator getDotDecoration() => DotsDecorator(
//         color: Color(0xFFBDBDBD),
//         //activeColor: Colors.orange,
//         size: Size(10, 10),
//         activeSize: Size(22, 10),
//         activeShape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(24),
//         ),
//       );

//   PageDecoration getPageDecoration() => PageDecoration(
//         titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//         bodyTextStyle: TextStyle(fontSize: 20),
//         descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
//         imagePadding: EdgeInsets.all(24),
//         pageColor: Colors.white,
//       );
// }

// Delayed