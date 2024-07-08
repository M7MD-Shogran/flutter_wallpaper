import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper/view/wrapper.dart';

class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  @override
  void initState() {
    sendVerifyLink();
    super.initState();
  }
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

sendVerifyLink() async {
  final user = FirebaseAuth.instance.currentUser!;
  await user.sendEmailVerification().then((value) => {
    Get.snackbar('Link sent', 'A Link has been send to your Email ',margin: EdgeInsets.all(30),snackPosition: SnackPosition.BOTTOM)
  });

  reload() async {
    await FirebaseAuth.instance.currentUser!.reload().then((value) => {Get.offAll(Wrapper())});
  }
}

