import 'package:easyconference/Screens/Signup/signup_screen.dart';
import 'package:easyconference/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:easyconference/Screens/Signup/components/background.dart';
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

  Future<int?> checkLogin() async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    int? check = await _databaseService.checkLogin(username, password);
    return check;
  }

  Future<String?> getuserID() async {
    String username = _usernameController.text;
    String? getID = await _databaseService.getUserID(username);
    return getID;
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
              const Text(
                "LOGIN ACCOUNT",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(height: size.height * 0.04),
              SvgPicture.asset("assets/icons/login.svg",
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

                    if (_usernameController.text.isNotEmpty ||
                        _passwordController.text.isNotEmpty) {
                      int? check = await checkLogin();
                      String? getID = await getuserID();
                      if (check != 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const HomePage();
                            },
                          ),
                        );
                      } else {
                        return alert(
                          context,
                          title: const Text('Error!'),
                          content: const Text('you cannot login, please try again!'),
                          textOK: const Text('Okay'),
                        );
                      }
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: true,
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
      ),
    );
  }
}
