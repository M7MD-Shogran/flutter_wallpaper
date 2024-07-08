import 'package:flutter/material.dart';
import 'package:wallpaper/components/colors.dart';

class Header extends StatelessWidget {
  final String srcImage, title;

  const Header({super.key, required this.srcImage, required this.title});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Image.asset(
            srcImage,
            height: MediaQuery.of(context).size.height * .4,
            width: double.infinity,
          ),
          Text(
            title,
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary, fontSize: 40, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}