import 'package:easyconference/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:easyconference/Screens/Login/components/background.dart';
import 'package:easyconference/Screens/Signup/signup_screen.dart';
import 'package:easyconference/components/already_have_an_account_acheck.dart';
import 'package:easyconference/components/rounded_button.dart';
import 'package:easyconference/components/rounded_input_field.dart';
import 'package:easyconference/components/rounded_password_field.dart';
import 'package:easyconference/responsive/responsive.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BodyDesktop extends StatelessWidget {
  const BodyDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.1,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: Responsive.isDesktop(context) ? 2 : 1,
              child: SvgPicture.asset(
                "assets/icons/login.svg",
                height: size.height * 0.45,
              ),
            ),
            SizedBox(
              width: size.height * 0.1,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedInputField(
                    hintText: "Your Email",
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),
                  RoundedPasswordField(
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),
                  RoundedButton(
                    text: "LOGIN",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const HomePage();
                          },
                        ),
                      );
                    },
                    height: size.height * 0.07,
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const SignUpScreen();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
