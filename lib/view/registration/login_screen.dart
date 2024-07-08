import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/components/colors.dart';
import 'package:get/get.dart';
import 'package:wallpaper/view/registration/components/header.dart';
import 'package:wallpaper/view/registration/forgot_screen.dart';
import 'package:wallpaper/view/registration/signup_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isLoading = false;

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.secondary,
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Header(
                    srcImage: 'assets/images/mobile_login.jpg',
                    title: 'Welcome Back',
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
                                  labelText: 'Email',
                                  textFieldIcon: Icon(Icons.email)),
                              cursorColor: ButtonColor,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              focusNode: _emailFocus,
                              onFieldSubmitted: (trem) {
                                _fieldFocusChange(
                                    context, _emailFocus, _passwordFocus);
                              }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(25),
                          elevation: 5,
                          shadowColor: Colors.black,
                          child: TextFormField(
                              controller: password,
                              decoration: editText(
                                labelText: 'Password',
                                textFieldIcon: Icon(Icons.lock),
                              ),
                              cursorColor: ButtonColor,
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              focusNode: _passwordFocus,
                              onFieldSubmitted: (value) {
                                _passwordFocus.unfocus();
                              }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          child: const Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: Text('Forget Password?',
                                style: TextStyle(
                                  color: PrimaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                )),
                          ),
                          onTap: () {
                            Get.to(Forgot());
                          },
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
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                  ),
                                  elevation: MaterialStateProperty.all(50),
                                  padding: MaterialStateProperty.all(
                                    EdgeInsets.only(
                                        left: 36,
                                        top: 12,
                                        right: 36,
                                        bottom: 12),
                                  ),
                                ),
                                onPressed: () {
                                  signIn(context, email, password);
                                  print(
                                      'email $email.text \n password $password.text');
                                },
                                child: const Text(
                                  'LOGIN',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text('You don\'t have an Account? ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400)),
                                InkWell(
                                    child: const Text('Register',
                                        style: TextStyle(
                                          color: PrimaryColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        )),
                                    onTap: () {
                                      Get.to(SignUp());
                                    })
                              ],
                            ),
                          ],
                        ),
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

  signIn(context, TextEditingController email, TextEditingController password) async {
    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text);
      Navigator.pop(context);
      Get.showSnackbar(GetSnackBar(
        // title: 'Oops!',
        message: 'Login Successfully, Welcome ${user?.displayName}',
        duration: Duration(seconds: 5),
        borderRadius: 25,
        margin: EdgeInsets.all(MediaQuery.of(context).size.width * .06),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ));

    } on FirebaseAuthException catch (e) {
      print(e.code);
      Get.showSnackbar(GetSnackBar(
        title: 'Oops!',
        message: 'invalid Email or Password \n (${e.code})',
        duration: Duration(seconds: 5),
        borderRadius: 25,
        margin: EdgeInsets.all(MediaQuery.of(context).size.width * .06),
        backgroundColor: Theme.of(context).colorScheme.primary,
      )
      );
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        title: 'Oops!',
        message: e.toString(),
        duration: Duration(seconds: 5),
        borderRadius: 25,
        margin: EdgeInsets.all(MediaQuery.of(context).size.height * 3),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ));
    }
    setState(() {
      isLoading = false;
    });
  }
}
