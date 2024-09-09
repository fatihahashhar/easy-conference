import 'package:flutter/material.dart';
import 'package:easyconference/Screens/Login/login_screen.dart';
import 'package:easyconference/models/login.dart';
import 'package:easyconference/Screens/Signup/components/background.dart';
import 'package:easyconference/Screens/Signup/components/or_divider.dart';
import 'package:easyconference/Screens/Signup/components/social_icon.dart';
import 'package:easyconference/components/already_have_an_account_acheck.dart';
import 'package:easyconference/services/database_service.dart';
import 'package:flutter_svg/svg.dart';
import 'package:alert_dialog/alert_dialog.dart';

class BodyMobile extends StatefulWidget {
  const BodyMobile({Key? key, this.login}) : super(key: key);
  final BodyMobile? login;

  @override
  State<BodyMobile> createState() => _BodyMobileState();
}

//retrieve all data in conference form
class _BodyMobileState extends State<BodyMobile> {
  final DatabaseService _databaseService = DatabaseService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _validateUsername = false;
  bool _validatePassword = false;

  final _formKey = GlobalKey<FormState>();

  Future<void> _onSave() async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    Login login = Login(username: username, password: password);

    return await _databaseService.insertLogin(login);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 24.0),
              const Text(
                "SIGN UP ACCOUNT",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              SvgPicture.asset("assets/icons/signup.svg",
                  height: size.height * 0.30),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.aod),
                  labelText: 'Username *',
                  errorText: _validateUsername ? '*Required' : null,
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.person),
                  labelText: 'Password *',
                  errorText: _validatePassword ? '*Required' : null,
                ),
              ),
              const SizedBox(height: 24.0),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 90),
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _usernameController.text.isEmpty
                          ? _validateUsername = true
                          : _validateUsername = false;
                    });
                    setState(() {
                      _passwordController.text.isEmpty
                          ? _validatePassword = true
                          : _validatePassword = false;
                    });

                    if (_usernameController.text.isEmpty ||
                        _passwordController.text.isEmpty) {
                    } else {
                      _onSave();
                      setState(() {});

                      return alert(
                        context,
                        title: const Text('Successful'),
                        content: const Text('Now you can login!'),
                        textOK: const Text('Okay'),
                      );
                    }
                  },
                  child: const Text(
                    'Register Account',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const LoginScreen();
                      },
                    ),
                  );
                },
              ),
              const OrDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocalIcon(
                    iconSrc: "assets/icons/facebook.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/twitter.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/google-plus.svg",
                    press: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
