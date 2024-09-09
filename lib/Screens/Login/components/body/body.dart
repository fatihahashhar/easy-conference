import 'package:flutter/material.dart';
import 'package:easyconference/responsive/responsive.dart';
import 'package:easyconference/Screens/Login/components/body/body_mobile.dart';
import 'package:easyconference/Screens/Login/components/body/body_desktop.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: BodyMobile(),
      desktop: BodyDesktop(),
    );
  }
}
