import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/components/colors.dart';
import 'package:wallpaper/view/registration/components/fotter.dart';
import 'package:wallpaper/view/registration/components/header.dart';

class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  TextEditingController email = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Header(
              srcImage: 'assets/images/mobile_login.jpg',
              title: 'Reset Password',
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(36, 20, 36, 0),
              child: Column(
                children: <Widget>[
                  Material(
                    borderRadius: BorderRadius.circular(25),
                    elevation: 5,
                    shadowColor: Colors.black,
                    child: TextFormField(
                        controller: email,
                        decoration: editText(
                            labelText: 'Enter your email',
                            textFieldIcon: Icon(Icons.email)),
                        cursorColor: ButtonColor,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        focusNode: _emailFocus,
                        onFieldSubmitted: (trem) {
                          _fieldFocusChange(
                              context, _emailFocus, _passwordFocus);
                        }),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .06,
                        width: MediaQuery.of(context).size.width * .6,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(ButtonColor),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                            ),
                            elevation: MaterialStateProperty.all(50),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.only(
                                  left: 36, top: 12, right: 36, bottom: 12),
                            ),
                          ),
                          onPressed: () {
                            reset(email);
                          },
                          child: const Text(
                            'RESET',
                            style:  TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration editText(
      {required String labelText, required Icon textFieldIcon}) {
    return InputDecoration(
      labelText: labelText,
      prefixIcon: textFieldIcon,
      filled: true,
      fillColor: PrimaryColor.withOpacity(.1),
      focusedBorder: OutlineInputBorder(
        gapPadding: 10,
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(color: PrimaryColor, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        gapPadding: 10,
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(
          color: Colors.white.withOpacity(.1),
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        gapPadding: 10,
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(color: ErrorColor, width: 1.5),
      ),
      labelStyle: TextStyle(color: Colors.grey.shade700),
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  reset(TextEditingController email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
  }
}
