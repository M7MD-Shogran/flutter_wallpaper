import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/components/colors.dart';
import 'package:wallpaper/view/registration/login_screen.dart';
import 'package:wallpaper/view/registration/signup_screen.dart';
import 'package:wallpaper/view/wallpaper.dart';

// ignore: must_be_immutable
class Footer extends StatelessWidget {
  final String textButton, textTitle, textToGo;
  //  whereToGo;
  // final Function onClickButton, onClickText;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

   Footer(
      {super.key,
      required this.textTitle,
      required this.textToGo,
      required this.email,
      // required this.onClickButton,
      // required this.onClickText,
      required this.textButton,
      // required this.whereToGo
      required this.password,
      confirmPassword,
      }) ;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * .06,
          width: MediaQuery.of(context).size.width * .6,
          child: TextButton(
            style:  ButtonStyle(
              backgroundColor: MaterialStateProperty.all(ButtonColor),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),),
              elevation: MaterialStateProperty.all(50),
              padding: MaterialStateProperty.all(EdgeInsets.only(left: 36, top: 12, right: 36, bottom: 12),),
            ),
            onPressed:(){
              // if(textButton == 'LOGIN'){
              //   signIn(email,password);
              //   print('email $email.text \n password $password.text');
              //   Navigator.pop(context);
              //   // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
              // }
              // else if(textButton == 'REGISTER'){
              //   singUp(email, password,confirmPassword);
              //   Navigator.pop(context);
              //    Navigator.push(context, MaterialPageRoute(builder: (context) => Wallpaper()));
              // }
              // else if(textButton == 'RESET'){
              //   reset(email);
              // }
            },
            child: Text(
              textButton,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
            Text(textTitle,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400)),
            InkWell(
              child: Text(textToGo,
                  style: const TextStyle(
                      color: PrimaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,)),
              onTap:(){
              //   switch(textToGo){
              //   case 'Login':
              //   Navigator.pop(context);
              //   Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
              //   break;
              //   case 'Register' :
              //   Navigator.pop(context);
              //   Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
              //   break;
              // }
              } 
              // onClickText,
            )
          ],
        ),
      ],
    );
  }




}