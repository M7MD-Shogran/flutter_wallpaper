import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper/components/colors.dart';
import 'package:wallpaper/view/registration/components/header.dart';
import 'package:wallpaper/view/registration/login_screen.dart';
import 'package:wallpaper/view/wallpaper.dart';
import 'package:wallpaper/view/wrapper.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  bool isLoading = false;

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _passwordConfiremFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Header(
                srcImage: 'assets/images/mobile_register.jpg',
                title: 'REGISTER',
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
                    const SizedBox(
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
                          // textInputAction: TextInputAction.next,
                          focusNode: _passwordFocus,
                          onFieldSubmitted: (trem) {
                            _fieldFocusChange(context, _passwordFocus,
                                _passwordConfiremFocus);
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(25),
                      elevation: 5,
                      shadowColor: Colors.black,
                      child: TextFormField(
                          controller: confirmPassword,
                          decoration: editText(
                            labelText: 'Confirm Password',
                            textFieldIcon: Icon(Icons.check_box),
                          ),
                          cursorColor: ButtonColor,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          focusNode: _passwordConfiremFocus,
                          onFieldSubmitted: (value) {
                            // _passwordFocus.unfocus();
                          }),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * .06,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * .6,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(ButtonColor),
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
                        // if(password == confirmPassword){
                        singUp(email, password, confirmPassword);
                        // Navigator.pop(context);
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => Wallpaper()));
                        // }
                        // else{
                        //   password.text = '';
                        //   confirmPassword.text = '';
                        //   Get.showSnackbar(
                        //     GetSnackBar(
                        //       // title: 'Oops!',
                        //       message: 'Wrong Password!',
                        //       duration: Duration(seconds: 5),
                        //       borderRadius: 25,
                        //       margin: EdgeInsets.all(MediaQuery.of(context).size.width * .06),
                        //       backgroundColor: Theme.of(context).colorScheme.secondary,
                        //     ),
                        //   );
                        // }
                      },
                      child: const Text(
                        'REGISTER',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
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
                      const Text('You have an Account? ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400)),
                      InkWell(
                          child: const Text('Login',
                              style: TextStyle(
                                color: PrimaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              )),
                          onTap: () {
                            Get.back();
                            Get.to(Login());
                          }
                        // onClickText,
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
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

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,
      FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  singUp(TextEditingController email, TextEditingController password,
      TextEditingController confirmPassword) async {
    setState(() {
      isLoading = true;
    });

    try {
      if (password == confirmPassword) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email.text, password: password.text);
        Get.offAll(Wrapper());
        Get.showSnackbar(
          GetSnackBar(
            // title: 'Oops!',
            message: 'Login Successfully, Welcome',
            duration: Duration(seconds: 3),
            borderRadius: 25,
            margin: EdgeInsets.all(MediaQuery
                .of(context)
                .size
                .width * .06),
            backgroundColor: Theme
                .of(context)
                .colorScheme
                .secondary,
          ),
        );
      } else {
        Get.showSnackbar(
          GetSnackBar(
            // title: 'Oops!',
            message: 'Wrong Password!',
            duration: Duration(seconds: 3),
            borderRadius: 25,
            margin: EdgeInsets.all(MediaQuery
                .of(context)
                .size
                .width * .06),
            backgroundColor: Theme
                .of(context)
                .colorScheme
                .secondary,
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      Get.showSnackbar(
          GetSnackBar(
            title: 'Oops!',
            message: e.code,
            duration: const Duration(seconds: 3),
            borderRadius: 25,
            margin: EdgeInsets.all(MediaQuery
                .of(context)
                .size
                .width * .06),
            backgroundColor: Theme
                .of(context)
                .colorScheme
                .secondary,
          ));
    } catch (e) {

        Get.showSnackbar(GetSnackBar(
          title: 'Oops!',
          message: e.toString(),
          duration: Duration(seconds: 3),
          borderRadius: 25,
          margin: EdgeInsets.all(MediaQuery
              .of(context)
              .size
              .height * .06),
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .secondary,
        ));

      setState(() {
        isLoading = false;
      });
    }
  }
}
